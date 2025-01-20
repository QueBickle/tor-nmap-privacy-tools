#!/bin/bash

TORRC="/etc/tor/torrc"

usage() {
    echo "Usage: $0 [OPTION]"
    echo "Options for Privacy-Conscious Users:"
    echo "  -c, --change-circuit       Request a new Tor circuit to potentially avoid tracking. Increases anonymity."
    echo "  -e, --exclude COUNTRY      Exclude nodes from a specific COUNTRY to avoid specific jurisdictions or surveillance."
    echo "  -p, --prefer COUNTRY       Prefer nodes from a COUNTRY for potentially better performance or to leverage data protection laws."
    echo "  -l, --list-exit-nodes      List current Tor exit nodes for transparency on where your traffic might exit."
    echo "  -r, --rules                Display node selection rules to understand how exclusion and preference affect your anonymity."
    echo "  -s, --scan TARGET [PORTS]  Scan TARGET with nmap through Tor for anonymous network reconnaissance. Specify PORTS for targeted scans."
    echo "  -n, --no-strict            Disable strict node selection for broader anonymity but potentially less control over path."
    echo "  -h, --help                 Display this help message for usage guidance."
    exit 1
}

change_circuit() {
    echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
    if [ $? -eq 0 ]; then
        echo "Circuit changed for enhanced privacy. New IP:"
        torify curl ifconfig.me
    else
        echo "Failed to change circuit. Ensure Tor is running and control port is accessible."
    fi
}

modify_torrc() {
    local option=$1
    local country=$2
    
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run this script with sudo for modifying torrc to ensure privacy settings are applied."
        exit 1
    fi

    case $option in
        exclude)
            echo "ExcludeNodes {${country}}" | sudo tee -a "$TORRC"
            echo "StrictNodes 1" | sudo tee -a "$TORRC"
            echo "Nodes from $country are now avoided in your Tor circuit."
            ;;
        prefer)
            echo "ExitNodes {${country}}" | sudo tee -a "$TORRC"
            echo "EntryNodes {${country}}" | sudo tee -a "$TORRC"
            echo "StrictNodes 1" | sudo tee -a "$TORRC"
            echo "Preferring nodes from $country for your Tor circuit."
            ;;
        *)
            usage
            ;;
    esac
    echo "Updated $TORRC. Please restart Tor to apply changes for privacy."
}

list_exit_nodes() {
    echo "Fetching current Tor exit nodes for transparency and peace of mind:"
    wget -qO- https://check.torproject.org/torbulkexitlist
}

display_rules() {
    echo "Node Selection Rules for Privacy Assurance:"
    echo "- **ExcludeNodes**: Avoids using nodes from listed countries or regions for your circuit, minimizing exposure to certain jurisdictions."
    echo "- **PreferNodes**: Attempts to use nodes from specified countries, which might offer better legal protections or performance."
    echo "- **StrictNodes**: When set to 1, strictly enforces node selection rules for more control over your anonymity path."
    echo "Note: Overly restrictive settings can reduce the anonymity pool and potentially make your traffic more identifiable."
}

scan_with_tor() {
    local target=$1
    local ports=$2

    if [ -z "$target" ]; then
        echo "Please specify a target for the scan to proceed anonymously."
        usage
    fi

    if [ -z "$ports" ]; then
        echo "Performing a basic anonymous scan on $target (ports 80,443):"
        torify nmap -sT -Pn -p 80,443 "$target"
    else
        echo "Performing a detailed anonymous scan on $target for ports: $ports"
        torify nmap -sT -Pn -p "$ports" "$target"
    fi
}

no_strict() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run this script with sudo to modify Tor settings."
        exit 1
    fi
    sudo sed -i '/StrictNodes/{s/1/0/}' "$TORRC"
    echo "Strict node selection disabled. Tor will now use a broader set of nodes for anonymity."
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--change-circuit)
            change_circuit
            exit 0
            ;;
        -e|--exclude)
            if [ -z "$2" ]; then
                echo "Please specify a country code to exclude for privacy reasons."
                exit 1
            fi
            modify_torrc "exclude" "$2"
            shift; shift
            ;;
        -p|--prefer)
            if [ -z "$2" ]; then
                echo "Please specify a country code to prefer for potentially better privacy or performance."
                exit 1
            fi
            modify_torrc "prefer" "$2"
            shift; shift
            ;;
        -l|--list-exit-nodes)
            list_exit_nodes
            exit 0
            ;;
        -r|--rules)
            display_rules
            exit 0
            ;;
        -s|--scan)
            if [ -z "$2" ]; then
                echo "Please specify a target to scan anonymously."
                usage
            fi
            scan_with_tor "$2" "$3"
            exit 0
            ;;
        -n|--no-strict)
            no_strict
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option $1. Privacy might be compromised if not used correctly."
            usage
            ;;
    esac
done

if [ $# -eq 0 ]; then
    usage
fi

if [ "$(id -u)" -eq 0 ]; then
    systemctl restart tor
    echo "Tor service restarted. Changes should now be in effect, ensuring your privacy."
else
    echo "Please run with 'sudo' for configuration changes to maintain your anonymity."
fi

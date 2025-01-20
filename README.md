# Tor & Nmap Privacy Manager

**Disclaimer:** This tool is provided for educational and ethical use only. Use of this script for unauthorized scanning, surveillance, or any activity against terms of service or laws is strictly prohibited and the author assumes no responsibility for misuse. Always ensure you have permission to scan any network, and use these tools in accordance with all applicable local and international laws.

A Bash script designed for users who prioritize privacy and anonymity when managing Tor circuits and conducting network reconnaissance with Nmap.

## Features

- **Change Tor Circuits**: Switch to new circuits to potentially avoid tracking.
- **Exclude or Prefer Nodes**: Control which countries' nodes your traffic uses or avoids.
- **List Tor Exit Nodes**: Gain transparency on where your traffic might exit the Tor network.
- **Display Node Selection Rules**: Understand how node selection impacts your privacy.
- **Anonymous Network Scanning**: Use Nmap through Tor for privacy-focused reconnaissance.
- **Toggle Strict Node Selection**: Choose between strict control over your path or broader anonymity.

## Installation

1. Clone this repository:
   ```bash
   git clone git@github.com:QueBickle/tor-nmap-privacy-tools.git
   cd tor-nmap-privacy-tools

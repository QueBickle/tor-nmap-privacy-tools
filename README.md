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

## Choosing Exit Nodes Explained Simply

Think of the internet like a big playground where you want to play hide and seek without anyone knowing it's you. Tor helps by making you take secret tunnels:

- **Why Choose an Exit Node?**: It's like picking which tunnel to pop out from. You want one where privacy is respected, like in countries with good privacy laws.

- **Picking by Country**:
  - **Good Privacy Laws**: Some places are like safe zones where your secrets stay secret. Like Germany or Switzerland, they're good for privacy.
  - **Avoiding Bad Places**: If some countries are like strict headmaster's offices where they watch everyone closely, you'd avoid those.

- **Performance**: Some tunnels might be faster, but remember, the fastest isn't always the safest.

- **How to Do It**:
  - **Exclude**: Tell Tor, "Don't let me come out near the principal's office!" (e.g., `-e US` to avoid the US).
  - **Prefer**: Ask Tor to try to use tunnels from safe spots. But Tor might choose differently to keep everyone's game fair (e.g., `-p DE` to try Germany).

- **Risks**: If you always come out from the same spot, you might be easier to find. Sometimes, letting Tor choose randomly is best for hiding.

- **Being Careful**: Even if you pick a good spot, the tunnel might be watched. Always play smart and legally.

## Installation

1. Clone this repository:
   ```bash
   git clone git@github.com:QueBickle/tor-nmap-privacy-tools.git
   cd tor-nmap-privacy-tools

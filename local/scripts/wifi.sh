#!/usr/bin/env bash

# TODO one action when executed via dmenu
# and another when executed via the shell

# CODOC *** How to setup wifi ***
# CODOC 
# CODOC wpa_cli scan
# CODOC wpa_cli scan_results
# CODOC wpa_cli add_network
# CODOC wpa_cli set_network <number> ssid "<ssid>"
# CODOC wpa_cli set_network <number> psk "<password>"
# CODOC enable_network <number>
# CODOC save config

# Test for network connection
HOST="8.8.8.8" # Google's DSN server

if ping -c 1 -W 1 "$HOST" > /dev/null 2>&1; then
	echo "Network...  connected"
	#echo "exiting..."
	#exit
else
	echo "Network...  ERROR: network is disconnected"
	echo "configuring..."
fi

# Scan for Networks via the shell
wpa_cli scan  # scan for networks
echo "scanning for networks..."
sleep 2.5
#wpa_cli scan_results

# Scan for Networks via dmenu
echo "WiFi Networks"
echo "------------------------------"
# Possibly useful:
wpa_cli scan_results | cut -f 5- | grep -v '^$'
SSID="$(wpa_cli scan_results | \
	sed 's/.*]//' | \
	sed 's/\t//' | \
	grep -v '^\s*$' | \
	grep -v '\\' | \
	grep -v 'Selected interface' | \
	grep -v '/' | \
	dmenu)"
echo ""

NET=`wpa_cli add_network | grep -E "[0-9]" | grep -v "[A-Z]"`
#read -p "ssid: " SSID
#wpa_cli set_network $NET ssid "SSID"
read -p "password: " PSK
#wpa_cli set_network $NET psk "PSK"
#enable_network [0 1 ...]
#save config

echo ''
echo network number: $NET
echo ssid: $SSID
echo pass: $PSK

#!/bin/bash

# Prompt the user to enter an IP address
read -p "Enter an IP address: " ip_address

# Display the entered IP address
echo "You entered the IP address: $ip_address"

# You can now use the $ip_address variable for further processing
match=$(echo cat /etc/netplan/00-installer-config.yaml  | grep -oP '\b(e\S+):')
echo "Match found: $match"
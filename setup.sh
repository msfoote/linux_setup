#!/bin/bash

# Prompt the user to enter an IP address
read -p "Enter an IP address: " ip_address

# Display the entered IP address
echo "You entered the IP address: $ip_address"

# You can now use the $ip_address variable for further processing
match=$(ip link  | grep -oP '\b(e\S+):')
echo "Match found: $match"

cp 'templates/00-installer-config.yaml.jinja' '~/00-installer-config.yaml'
sed -i "s/{{ network_device_name }}/$match/g" 00-installer-config.yaml
sed -i "s/{{ ip_address }}/$ip_address/g" 00-installer-config.yaml
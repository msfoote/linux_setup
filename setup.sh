#!/bin/bash

# Prompt the user to enter an IP address
read -p "Enter an IP address: " ip_address

# Display the entered IP address
echo "You entered the IP address: $ip_address"

# You can now use the $ip_address variable for further processing
match=$(ip link  | grep -oP '\b(e\S+):')

# Copy the template and replace the appropriate values
cp 'templates/00-installer-config.yaml.jinja' '00-installer-config.yaml'
sed -i "s/{{ network_device_name }}/$match/g" 00-installer-config.yaml
sed -i "s/{{ ip_address }}/$ip_address/g" 00-installer-config.yaml

# Confirm the ip address is correct
read -p "Please confirm you wish to use $ip_address? (Y/N): " response
if [[ "$response" =~ ^[Yy] ]]; then
    sudo cp '/etc/netplan/00-installer-config.yaml' '/etc/netplan/00-installer-config.yaml.bak'
    sudo cp '00-installer-config.yaml' '/etc/netplan/00-installer-config.yaml'
    sudo netplan apply
    echo "Complete."
else
    echo "Aborted."
fi
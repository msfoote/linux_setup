#!/bin/bash

# Prompt the user to enter an IP address
read -p "Enter an IP address: " ip_address

# Display the entered IP address
echo "You entered the IP address: $ip_address"

# You can now use the $ip_address variable for further processing
match=$(ip link  | grep -oP '\b(e\S+):')


# Confirm the ip address is correct
read -p "Please confirm you wish to use $ip_address? (Y/N): " response
if [[ "$response" =~ ^[Yy] ]]; then
    # Copy the template and replace the appropriate values
    cp 'templates/00-installer-config.yaml.jinja' '00-installer-config.yaml'
    sed -i "s/{{ network_device_name }}/$match/g" 00-installer-config.yaml
    sed -i "s/{{ ip_address }}/$ip_address/g" 00-installer-config.yaml
    
    # Backup the existing configuration file
    sudo cp '/etc/netplan/00-installer-config.yaml' '/etc/netplan/00-installer-config.yaml.bak'
    
    # Copy the new file to the appropriate location
    sudo cp '00-installer-config.yaml' '/etc/netplan/00-installer-config.yaml'
    
    # Remove the changed template file
    rm '00-installer-config.yaml'
    
    # Apply the configuration
    sudo netplan apply
    
    echo "Complete."
else
    echo "Aborted."
fi
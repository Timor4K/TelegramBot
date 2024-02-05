#!/bin/bash

# Check if an IP address is provided
if [ -z "$1" ]; then
    echo "Please provide IP address"
    exit 1
fi

# Set key path
KEY_PATH=~/.ssh/key.pem

# Generate new key pair
ssh-keygen -t rsa -b 2048 -f ~/.ssh/new_key -N ""

# Ensure authorized_keys file exists
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

# Copy the public key to the authorized_keys file on the private instance
cat ~/.ssh/new_key.pub >> ~/.ssh/authorized_keys

# Clean up old keys
rm $KEY_PATH
mv ~/.ssh/new_key $KEY_PATH
rm ~/.ssh/new_key.pub

# Display success message
echo "Key rotation successful. New private key: $KEY_PATH"

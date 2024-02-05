#!/bin/bash

# Check if KEY_PATH environment variable is set
if [ -z "$KEY_PATH" ]; then
    echo "ERROR: The KEY_PATH environment variable is expected."
    exit 5
fi

# Check for the correct number of arguments
if [ "$#" -lt 1 ]; then
    echo "ERROR: Please provide the Bastion IP address."
    exit 5
fi

# Assign command line arguments to variables
BASTION_IP="$1"
PRIVATE_IP="${2:-}"

# Construct the SSH command
ssh_command="ssh -i $KEY_PATH"

# If only one argument is provided, connect to the public instance
if [ "$#" -eq 1 ]; then
    ssh_command="$ssh_command ubuntu@$BASTION_IP"
fi

# If two arguments are provided, connect to the private instance via bastion
if [ "$#" -gt 1 ]; then
    ssh_command="$ssh_command -o ProxyCommand=\"ssh -W %h:%p -i $KEY_PATH ubuntu@$BASTION_IP\" ubuntu@$PRIVATE_IP"
fi

# Execute the SSH command with any additional arguments
if [ "$#" -gt 2 ]; then
    additional_commands="${@:3}"
    ssh_command="$ssh_command $additional_commands"
fi

# Execute the constructed SSH command
eval "$ssh_command"

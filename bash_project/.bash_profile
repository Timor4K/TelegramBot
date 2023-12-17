#!/bin/bash
# .bash_profile
USER=$(whoami)
echo "Hello $USER"
export COURSE_ID="DevOpsBootcampElevation"
# Get file path
token_file="$HOME/.token"
if [ -e "$token_file" ]; then
  permissions=$(stat -c "%a" "$token_file")
  if [ "$permissions" -ne 600 ]; then
    echo "Warning: .token file has too open permissions"
    # Set file permissions to 600
    if chmod 600 "$token_file"; then
      echo "Permissions set to 600 successfully."
    else
      echo "Error: Failed to set permissions to 600."
      exit 1
    fi
  fi
else
  echo "Warning: $token_file file does not exist"
fi

umask 0006
export PATH="$PATH:/home/$USER/usercommands"

alias ltxt='ls *.txt'

current_date=$(date -u +"%Y-%m-%dT%H:%M:%S%z")
echo "Current date:  $current_date"

tmp_dir="$HOME/tmp"
if [[ ! -d "$tmp_dir" ]]; then
    mkdir "$tmp_dir"
else
    rm -rf "$tmp_dir/*"
fi

pid=$(lsof -ti tcp:8080)
if [ -n "$pid" ]; then
    if kill "$pid"; then
        echo "Process $pid successfully killed."
    else
        echo "Warning: Failed to kill process $pid."
    fi
else
    echo "No process found on port 8080."
fi

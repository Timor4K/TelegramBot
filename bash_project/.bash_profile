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

pid=$(lsof -ti tcp:8080 | head -n 2 | tail -n 1)
if [[ ! -z "$pid" ]]; then
    kill "$pid"
else
    echo "No process found on port 8080."
fi

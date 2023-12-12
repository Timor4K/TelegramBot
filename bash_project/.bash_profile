#!/bin/bash

echo "Hello $USER"

export COURSE_ID="DevOpsBootcampElevation"

FILE="$HOME/.token"
if ! [[ -f "$FILE" ]]; then
    touch $FILE && sudo chmod 600 $FILE
fi
if ! [[ $(stat -c '%a' "$FILE") == "600" ]]; then
	echo "Warning: .token file has too open permissions"
fi

umask 117

export PATH=$PATH+":/home/$USER/usercommands"

time=$(date '+%Y-%m-%dT%H:%M:%S%z')
echo "${time:0:-2}:${time:(-2)}"

shopt -s expand_aliases
alias ltxt="ls | grep *.txt"

fname="tmp"
if ! [[ -d "$HOME/$fname" ]]; then
	mkdir "$HOME/$fname"
	echo "$fname folder -created"
else
    sudo rm -rf "$HOME/$fname/*"
    echo "$fname folder - all files removed"
fi
pid=$(sudo lsof -t -i:8080)
! [[ $pid == "" ]] && kill -9 "$pid" || echo "There is no Process run on port 8080"
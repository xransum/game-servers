#!/bin/bash

USER="$1"
if [ -z "$USER" ]; then
    echo "Usage: $0 <user>"
    exit 1
fi

session_names() {
    sudo su - "$USER" -c "screen -ls | grep -e '[0-9]\+\.' | awk '{print \$1}'" | cut -d'.' -f2
}

# Print each session name with a number prefix
i=1
for session in $(session_names); do
    echo "$i: $session"
    ((i++))
done

# Prompt the user to select a session
printf "Select a session: "
read -r session_number

# Get the session name by number
session_name=$(session_names | sed -n "${session_number}p")

if [ -z "$session_name" ]; then
    echo "Invalid session number."
    exit 1
fi

# Prompt for the command to send to the session
printf "Enter the command to send to the session: "
read -r command

# Send the command to the session
sudo su - "$USER" -c "screen -S $session_name -X stuff \"$command^M\""

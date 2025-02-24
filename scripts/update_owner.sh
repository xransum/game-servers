#!/bin/bash
# Must be run as root

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

USER="$1"
GROUP="$2"

if [ -z "$USER" ] || [ -z "$GROUP" ]; then
    echo "Usage: $0 <user> <group>"
    exit 1
fi

sudo chown -R -v "${USER}:${GROUP}" /home/"${USER}"/

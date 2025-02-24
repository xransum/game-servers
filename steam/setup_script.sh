#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

echo "Updating system"
apt update && apt upgrade -y

# Install curl if it doesn't exist
if ! command curl --version &>/dev/null; then
    echo "curl is not installed"
    apt-get install curl -y
fi

# Presetting Values for liscence agreement keys using debconf-set-selections
echo steam steam/question select "I AGREE" | debconf-set-selections
echo steam steam/license note '' | debconf-set-selections

# Install SteamCMD
echo "Installing SteamCMD"
apt install software-properties-common
apt-add-repository non-free
dpkg --add-architecture i386
apt update
apt install steamcmd --yes

SERVICE_USER="steam"
SERVICE_GROUP="steam"

# Create group if it doesn't exist
if [ "$(getent group "${SERVICE_GROUP}")" ]; then
    groupadd "${SERVICE_GROUP}"
else
    echo "Group ${SERVICE_GROUP} already exists"
fi

# Create user if it doesn't exist
if ! id -u "${SERVICE_USER}" >/dev/null 2>&1; then
    echo "Creating user ${SERVICE_USER}"
    useradd --system --shell "$(which bash)" --home /home/"${SERVICE_USER}" -g "${SERVICE_GROUP}" "${SERVICE_USER}"
else
    echo "User ${SERVICE_USER} already exists"
fi

# Create home directory
if [ ! -d "/home/${SERVICE_USER}" ]; then
    mkhomedir_helper "${SERVICE_USER}"
else
    echo "Home directory /home/${SERVICE_USER} already exists"
fi

#!/bin/bash

# Update everything
sudo apt update -y && sudo apt upgrade -y

# Install dependencies
sudo apt install -y git nano curl wget grep zip unzip bash screen

# Create user
sudo groupadd minecraft
sudo useradd --system --shell "$(which bash)" --home /home/minecraft -g minecraft minecraft
sudo mkhomedir_helper minecraft
sudo su - minecraft

# Install Java JRE's: 8, 11, 17, & 19
sudo apt install -y openjdk-8-jre openjdk-11-jre openjdk-17-jre openjdk-19-jre

# Configure defaults
sudo update-alternatives --config java

# Setup MC systemctl
sudo nano /etc/systemd/system/minecraft@.service
sudo systemctl daemon-reload

sudo logrotate -vf /etc/logrotate.d/minecraft
sudo cat /home/minecraft/all-the-mods-8/screenlog.0

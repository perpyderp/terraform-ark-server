#!/bin/sh

# Update system
sudo yum update

# As the root user, create the steam user
sudo useradd -m steam
sudo passwd steam

# Go into its home folder
sudo -u steam -s
cd /home/steam

# Install the dependencies required to run SteamCMD
sudo yum install glibc.i686 libstdc++.i686

# As the root user, escalate to the steam user
su - steam

# Create a directory to store SteamCMD and navigate into it
mkdir ~/Steam && cd ~/Steam

# Download and extract SteamCMD
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xvzf steamcmd_linux.tar.gz

# Create a folder/directory to store the server files
mkdir /home/steam/servers/ark


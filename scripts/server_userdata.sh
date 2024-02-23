#!/bin/sh

# Update system
sudo yum update

# As the root user, create the steam user
# sudo useradd -m steam
# sudo passwd steam

# As the root user, escalate to the steam user
# sudo -u steam -s

# Go into its home folder
cd /home/steam

# Install the dependencies required to run SteamCMD
sudo yum install glibc.i686 libstdc++.i686 -y || { echo "Failed to SteamCMD dependencies" >> /home/ec2-user/script.log; exit 1; }

# Create a directory to store SteamCMD and navigate into it
mkdir /home/steam
mkdir /home/steam/steamcmd
cd /home/steam/steamcmd

# Download and extract SteamCMD
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz

# Create a folder/directory to store the server files
mkdir /home/steam/servers
mkdir /home/steam/servers/ark

cd /home/steam/servers/ark

sudo ../../steamcmd/steamcmd.sh
force_install_dir /home/steam/servers/ark
login anonymous
app_update 376030 validate || { echo "Failed to install Ark" >> /home/ec2-user/script.log; exit 1; }
exit

cd /home/steam/servers/ark/ShooterGame/Binaries/Linux/

touch server_start.sh || { echo "Failed to create startup script" >> /home/ec2-user/script.log; exit 1; }

sudo echo '#!/bin/bash' > ./server_start.sh
sudo echo "./ShooterGameServer ${SERVER_MAP}?listen?SessionName=${SERVER_NAME}?ServerPassword=${SERVER_PASSWORD}?MaxPlayers=${MAX_PLAYERS}?ServerAdminPassword=${ADMIN_PASSWORD} -server -log" >> ./server_start.sh

chmod +x server_start.sh

./server_start.sh
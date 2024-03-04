#!/bin/bash

# Update system
sudo yum update

# As the root user, create the steam user
sudo useradd -m steam
# sudo passwd steam

# Go into its home folder
sudo -u steam -s || { echo "Failed to change to steam home folder" >> /home/ec2-user/script.log; exit 1; }
cd /home/steam || { echo "Failed to change to steam home folder" >> /home/ec2-user/script.log; exit 1; }

# Install the dependencies required to run SteamCMD
sudo yum install glibc.i686 libstdc++.i686 -y || { echo "Failed to SteamCMD dependencies" >> /home/ec2-user/script.log; exit 1; }

# As the root user, escalate to the steam user
su - steam || { echo "Failed to escalate steam user" >> /home/ec2-user/script.log; exit 1; }

# Create a directory to store SteamCMD and navigate into it
mkdir /home/steam/steamcmd || { echo "Failed to make steamcmd folder" >> /home/ec2-user/script.log; exit 1; }
cd /home/steam/steamcmd || { echo "Failed to cd to steamcmd folder" >> /home/ec2-user/script.log; exit 1; }

# Download and extract SteamCMD
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz || { echo "Failed install steamcmd" >> /home/ec2-user/script.log; exit 1; }
tar -xvzf steamcmd_linux.tar.gz || { echo "Failed to unpack steamcmd" >> /home/ec2-user/script.log; exit 1; }

# Create a folder/directory to store the server files
mkdir /home/steam/servers || { echo "Failed to create servers folder" >> /home/ec2-user/script.log; exit 1; }
mkdir /home/steam/servers/ark || { echo "Failed to create ark folder" >> /home/ec2-user/script.log; exit 1; }

cd /home/steam/servers/ark || { echo "Failed to cd to ark folder" >> /home/ec2-user/script.log; exit 1; }

/home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/servers/ark +login anonymous +app_update 376030 validate +quit || { echo "Failed to change to install Ark app" >> /home/ec2-user/script.log; exit 1; }
# force_install_dir /home/steam/servers/ark
# login anonymous
# app_update 376030 validate || { echo "Failed to install Ark" >> /home/ec2-user/script.log; exit 1; }
# exit

cd /home/steam/servers/ark/ShooterGame/Binaries/Linux/ || { echo "Failed to cd to linux script folder" >> /home/ec2-user/script.log; exit 1; }

touch server_start.sh || { echo "Failed to create startup script" >> /home/ec2-user/script.log; exit 1; }

sudo echo '#!/bin/bash' > ./server_start.sh || { echo "Failed to echo to server_start.sh" >> /home/ec2-user/script.log; exit 1; }
sudo echo "./ShooterGameServer $SERVER_MAP?SessionName=$SERVER_NAME?ServerPassword=$SERVER_PASSWORD?MaxPlayers=$MAX_PLAYERS?ServerAdminPassword=$ADMIN_PASSWORD -server -log" >> ./server_start.sh || { echo "Failed to echo to server_start.sh" >> /home/ec2-user/script.log; exit 1; }

chmod +x server_start.sh || { echo "Failed to set exec permissions to script" >> /home/ec2-user/script.log; exit 1; }

./server_start.sh || { echo "Failed to change to start server start script" >> /home/ec2-user/script.log; exit 1; }
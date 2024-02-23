#!/bin/sh

./ShooterGameServer ${SERVER_MAP}?listen?SessionName=${SERVER_NAME}?ServerPassword=${SERVER_PASSWORD}?MaxPlayers=${MAX_PLAYERS}?ServerAdminPassword=${ADMIN_PASSWORD} -server -log || { echo "Failed to create startup script" >> /home/ec2-user/script.log; exit 1; }

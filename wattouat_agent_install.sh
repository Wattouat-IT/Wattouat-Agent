#!/bin/bash
echo ""
echo "/******************************************************/"
echo "/*               WATTOUAT PROJECT AGENT               */"
echo -e "/******************************************************/\n"

sleep 2

# Install requierements
bash requierement.sh

# Create directory for Wattouat Agent
mkdir /bin/wattouat_agent 

# Up Service
cp wattouat_agent.service /etc/systemd/system/
cp fonction/wattouat_agent_service.sh /usr/bin/ 
chmod +x /bin/wattouat/wattouat_agent_service.sh

# Function
cp -R fonction /bin/wattouat_agent/

# Config file

cp wattouat_agent.conf /bin/wattouat_agent/
cp cpu_proc.txt /bin/wattouat_agent/

# Création des commandes 
echo "alias wattouat_node='bash /bin/wattouat_agent/fonction/mysql/node_info.sh'" >> ~/.bashrc
exec bash 

echo ""
echo "/******************************************************/"
echo "/*                       Finish                        */"
echo -e "/******************************************************/\n"
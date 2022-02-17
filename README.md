# Wattouat Agent

The first release was only tested and developed on Debian Buster. Don't try with a other because we don't know if it is still stable. 

## Prerequisites

- Debian buster 
- Internet connection
- Git (apt install git) 
- Be root (su) 

## Server installation

``` shell 
git clone https://github.com/Wattouat-IT/Wattouat-Agent.git
cd Wattouat-Agent
bash wattouat_agent_install.sh
```

## Agent Wattouat

Launch the service

Start the service at boot time

``` shell 
systemctl enable wattouat_agent
```

``` shell 
systemctl start wattouat_agent
```

## Configuration file 

Into the file ```/bin/wattouat_agent/``` edit the file with yout configuration

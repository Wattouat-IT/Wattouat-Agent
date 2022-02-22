# Wattouat Agent

## Prerequisites

- Internet connection
- Git
- Root

## Stable version

Supported version :

- ![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)
    - [X] Bullseye 
        - Status : Stable
    - [X] Buster
        - Status : Stable
    - [ ] Strech
        - Status : Not tested

- ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
    - [X] 21.04 LTS
        - Status : Stable
    - [X] 20.04 LTS
        - Status : Stable
    - [X] 18.04 LTS
        - Status : Stable

## Clone the repositorie

``` shell 
git clone https://github.com/Wattouat-IT/Wattouat-Server.git
```

## Edit the configuration file

Edit the file ``` wattouat.conf```

 - ip : your local ip who run the database

## Agent installation

``` shell 
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

## Uninstall Wattouat Agent

Go into ```/bin/wattouat_agentw/fonction```

Execute file ```wattouat_agent_uninstall.sh```
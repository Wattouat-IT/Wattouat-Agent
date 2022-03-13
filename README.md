# Wattouat Agent

## Table of Contents

- [Stable version](#stable-version)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Log file](#log-file)
- [Uninstall Wattouat Agent](#uninstall-wattouat-agent)

## Stable version

Supported version:

- ![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge=appveyor&logo=debian&logoColor=white)
    - [X] Bullseye 
        - Status: Stable
    - [X] Buster
        - Status: Stable
    - [ ] Strech
        - Status: Not tested

- ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge=appveyor&logo=ubuntu&logoColor=white)
    - [X] 21.04 LTS
        - Status: Stable
    - [X] 20.04 LTS
        - Status: Stable
    - [X] 18.04 LTS
        - Status: Stable

## Prerequisites

- Internet connection
- Git
- Root
- Installation Wattouat Server

## Installation 

### Clone the repositorie

``` shell 
git clone https://github.com/Wattouat-IT/Wattouat-Agent.git
```

And go inside the folder Wattouat-Agent

### Edit the configuration file

Edit the file ``` wattouat_agent.conf```

 - ip : your local ip who run the database
 - service : under "# Service scanned". Place the services for which you want to calculate the cost, separate with a comma. Example: ```<service1>,<service2>,<service3>,<serviceN>```

### Agent installation

``` shell 
bash wattouat_agent_install.sh
```

### Agent Wattouat

Launch the service

Start the service at boot time

``` shell 
systemctl enable wattouat_agent
```

``` shell 
systemctl start wattouat_agent
```

## Log file 

Go into ```/var/log/wattouat_agent/```

There are 2 files: 

First is for Standard Output

Second is for Standard Error

## Uninstall Wattouat Agent

Go into ```/bin/wattouat_agentw/fonction```

Execute file ```wattouat_agent_uninstall.sh```

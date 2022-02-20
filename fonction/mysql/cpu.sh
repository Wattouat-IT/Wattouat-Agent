#!/bin/bash

ip=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "ip")
ip=$(echo $ip | sed 's/.*=//')

id_node_info=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "id_node_info")
id_node_info=$(echo $id_node_info | sed 's/.*=//')

cpu_model=$(cat /proc/cpuinfo  | grep "model name")
cpu_model=$(echo $cpu_model | sed 's/.*://')

# Frenquency of the CPU in MHz
cpu_mhz=$(cat /proc/cpuinfo  | grep "cpu MHz")
cpu_mhz=$(echo $cpu_mhz | sed 's/.*://')

# Total core
cpu_core=$(cat /proc/cpuinfo | grep "cpu cores")
cpu_core=$(echo $cpu_core | sed 's/.*://')

mysql -u admin -proot elisa -h $ip -e "INSERT INTO cpu (cpu_model, cpu_mhz, cpu_core, id_node_info) VALUES ('$cpu_model', '$cpu_mhz', '$cpu_core', '$id_node_info');"

sleep 1

cpu_id=$(mysql -u admin -proot elisa -h $ip -e "SELECT MAX( id ) FROM node_info;" | sed 's/[^0-9]//g')
cpu_id=$(echo $cpu_id)
echo "# ID of this CPU node into elisa database" >> /bin/wattouat_agent/wattouat_agent.conf
echo "cpu_id=$cpu_id" >> /bin/wattouat_agent/wattouat_agent.conf
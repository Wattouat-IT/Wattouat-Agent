#!bin/bash

ip=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "ip")
ip=$(echo $ip | sed 's/.*=//')

host_name=$(cat /etc/hostname)

os=$(grep '^PRETTY' /etc/os-release)
os=$(echo $os | sed 's/.*=//' | sed 's/^.//' | sed 's/.$//')

ip_host=$(hostname -I | awk '{print $1}')

up_time=$(uptime -s | sed 's/.*up//')
up_time=$(echo $up_time | sed 's/,.*//' | sed 's/ .*//')

day_time=$(uptime | sed 's/.*up//')
day_time=$(echo $day_time | sed 's/,.*//')

mysql -u admin -proot elisa -h $ip -e "INSERT INTO node_info (host_name, os, ip, date_add, up_time, day_time)  VALUES ('$host_name', '$os', '$ip_host', NOW(), '$up_time', '$day_time');"

sleep 1

id_node_info=$(mysql -u admin -proot elisa -h $ip -e "SELECT MAX( id ) FROM node_info;" | sed 's/[^0-9]//g')
id_node_info=$(echo $id_node_info)
echo "# ID of this node into elisa database" >> /bin/wattouat_agent/wattouat_agent.conf
echo "id_node_info=$id_node_info" >> /bin/wattouat_agent/wattouat_agent.conf
echo "The node has been added on the server : $ip"
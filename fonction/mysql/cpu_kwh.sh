#!/bin/bash

ip=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "ip")
ip=$(echo $ip | sed 's/.*=//')

cpu_id=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "cpu_id")
cpu_id=$(echo $cpu_id | sed 's/.*=//')

id_node_info=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "id_node_info")
id_node_info=$(echo $id_node_info | sed 's/.*=//')

name_cpu=$(mysql -u admin -proot elisa -h $ip -e "SELECT * FROM cpu WHERE id_node_info=$id_node_info;" | sed -n 2p | sed 's/^.//' | sed -e 's/^[ \t]*//' | sed 's/GHz.*//')
GHz=GHz
name_cpu=$(echo $name_cpu$GHz)

tdp=$(cat /bin/wattouat_agent/cpu_proc.txt | grep "$name_cpu")
tdp=$(echo $tdp | sed 's/.*=//')

n=60
runtime="2 minute"
endtime=$(date -ud "$runtime" +%s)
cpu2=0

while [[ $(date -u +%s) -le $endtime ]]
do
    cpu1=$(uptime | sed 's/^.*ge: \(.*\), .* 0.*/\1/')
    cpu1=$(echo $cpu1 | sed 's/\,/./')
    cpu2=$(bc -l <<< "$cpu2 + $cpu1")
    sleep 60
done

moyen_cpu=$(bc -l <<< "$cpu2 / $n") 

cpu_core=$(cat /proc/cpuinfo | grep "cpu cores")
cpu_core=$(echo $cpu_core | sed 's/.*://')

d=100
e=$(bc -l <<< "$cpu_core * $tdp * $moyen_cpu / $d")

mysql -u admin -proot elisa -h $ip -e "INSERT INTO kwh (kwh, cpu_id) VALUES ('$e', '$cpu_id');"
mysql -u admin -proot elisa -h $ip -e "INSERT INTO temps (temps, cpu_id) VALUES (NOW(), '$cpu_id');"

#!/bin/bash

ip=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "ip")
ip=$(echo $ip | sed 's/.*=//')

id_node_info=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "id_node_info")
id_node_info=$(echo $id_node_info | sed 's/.*=//')

name_cpu=$(mysql -u admin -proot elisa -h $ip -e "SELECT * FROM cpu WHERE id_node_info=$id_node_info;" | sed -n 2p | sed 's/^.//' | sed -e 's/^[ \t]*//' | sed 's/GHz.*//')
GHz=GHz
name_cpu=$(echo $name_cpu$GHz)

tdp=$(cat /bin/wattouat_agent/cpu_proc.txt | grep "$name_cpu")
tdp=$(echo $tdp | sed 's/.*=//')

n=60
cpu1=0
memory1=0
d=1000
runtime="60 minute"
endtime=$(date -ud "$runtime" +%s)

a=1
number=$(grep -n "# Service scanned" /bin/wattouat_agent/wattouat_agent.conf)
number=$( echo $number | sed 's/:.*//' )
number=$(($number+$a))
service_list=$(sed -n ${number}p /bin/wattouat_agent/wattouat_agent.conf)
service_list=$(echo "$service_list")

Field_Separator=$IFS
IFS=,

if [ -z "$service_list" ]
then
    command
else
    for val in $service_list;
    do
        while [[ $(date -u +%s) -le $endtime ]]
        do
            cmd=$(ps -C $val -o %cpu)
            cpu=$(echo $cmd | sed -n '1!p' | sed 's/ //')
            cpu1=$(bc -l <<< "$cpu1 + $cpu")

            cmd1=$(ps -C $val -o %mem)
            memory=$(echo $cmd1 | sed -n '1!p' | sed 's/ //')
            memory1=$(bc -l <<< "$memory1 + $memory")
            sleep 60
        done

        moyen_cpu=$(bc -l <<< "$cpu1 / $n")
        moyen_memory=$(bc -l <<< "$memory1 / $n")
        moyen_cpu=$(bc -l <<< "$moyen_cpu / 100")
        moyen_memory=$(bc -l <<< "$moyen_memory / 100")

        cpu_core=$(cat /proc/cpuinfo | grep "cpu cores")
        cpu_core=$(echo $cpu_core | sed 's/.*://')

        e=$(bc -l <<< "$cpu_core * $tdp * $moyen_cpu + $moyen_memory / $d") # 1 heure

        id_service=$(mysql -B --disable-column-names -u admin -proot elisa -h $ip -e "select service.id from service, node_info where service_name='$val' and node_info.id='$id_node_info';")
        
        mysql -u admin -proot elisa -h $ip -e "INSERT INTO kwh_service (kwh, temps, service_id) VALUES ('$e', NOW(), '$id_service');"
    
    done
    IFS=$Field_Separator
fi








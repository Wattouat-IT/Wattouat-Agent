#!/bin/bash

ip=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "ip")
ip=$(echo $ip | sed 's/.*=//')

id_node_info=$(cat /bin/wattouat_agent/wattouat_agent.conf | grep "id_node_info")
id_node_info=$(echo $id_node_info | sed 's/.*=//')

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
    for var in $service_list;
    do
        RESULT_VARIABLE="$(mysql -u admin -proot elisa -h $ip -sse "SELECT EXISTS(SELECT 1 FROM service WHERE service_name = '$var')")"
        if [ "$RESULT_VARIABLE" = 1 ]; then
            command
        else
            mysql -u admin -proot elisa -h $ip -e "INSERT INTO service (service_name, id_node_info) VALUES ('$var', '$id_node_info');"
        fi
    done
    IFS=$Field_Separator
fi
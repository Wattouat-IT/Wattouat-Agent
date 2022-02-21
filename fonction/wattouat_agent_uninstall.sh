#!/bin/bash
echo "DANGER ZONE" 
echo "Are you sure to uninstall Wattouat Agent"
echo "  1)YES"
echo "  2)NO"

read n
case $n in
  1) echo "Wattouat uninstall"
    systemctl stop wattouat_agent

	  ip=$(cat /bin/wattouat/wattouat.conf | grep "ip")
    ip=$(echo $ip | sed 's/.*=//')   

	  rm -rf /etc/systemd/system/wattouat_agent.service
	  rm -rf /bin/wattouat_agent
	  ;;
  2) echo "Exit"
	  exit
	  ;;
  *) echo "invalid option";;
esac
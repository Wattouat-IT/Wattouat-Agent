#!/bin/bash

bash /bin/wattouat_agent/fonction/mysql/update_node_info_up_time.sh

bash /bin/wattouat_agent/fonction/run_update_node_info_day_time.sh &
bash /bin/wattouat_agent/fonction/run_cpu.sh &
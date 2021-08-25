#!/usr/bin/env bash

host_name=$(hostname -s)
if [ -d "/sys/class/fc_host" ]; then
  cd /sys/class/fc_host/
  printf '%-20b%-12b%-12b%-30b\n' "Hostname:" "Device:" "Port State:" "Port Name:"
  for i in $(ls)
    do
      device=$i
      p_n=$(cat $i/port_name)
      port_name="${p_n:2:2}:${p_n:4:2}:${p_n:6:2}:${p_n:8:2}:${p_n:10:2}:${p_n:12:2}:${p_n:14:2}:${p_n:16:2}"
      port_state=$(cat $i/port_state)
      printf '%-20b%-12b%-12b%-30b\n' "${host_name}" "${device}" "${port_state}" "${port_name}"
    done
else
  echo "fc_host directory does not exist!!!"
fi

#!/usr/bin/env bash

red="\033[0;31m"
green="\e[32m"
bold="\033[1m"
def="\033[0m"

for container_name in $(docker ps | grep -v "IMAGE" | awk 'NF>1{print $NF}')
do
  printf '%-15b: %b\n' "${red}${bold}Container Name" "${container_name}${def}"
  echo "---------------"
  mounts=$(docker inspect --format='{{range .Mounts}}{{ .Source }} {{ .Destination }}:{{end}}' ${container_name})
  IFS=':' read -r -a mounts_arr <<< "${mounts}"
  echo -e "${green}Mounts:${def}"
  for line in "${mounts_arr[@]}"
  do
    line_arr=(${line})
    echo "${line_arr[0]} --> ${line_arr[1]}"
  done
  echo
  echo
done

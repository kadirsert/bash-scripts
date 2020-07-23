#!/usr/bin/env bash

red="\033[0;31m"
green="\e[32m"
bold="\033[1m"
def="\033[0m"

for net_name in $(docker network ls |tail -n +2 |awk '{print $2}')
do
  printf '%-4b: %32b\n' "${red}${bold}Name" "${net_name}${def}"
  echo "----------------------------------"
  net_driver=$(docker network inspect --format='{{ .Driver }}' ${net_name})
  echo -e "${green}Driver:${def} ${net_driver}"
  if [ "${net_driver}" == "bridge" ]; then
    echo -en "${green}Binding IP:${def} "
    docker network inspect --format='{{ index .Options "com.docker.network.bridge.host_binding_ipv4" }}' ${net_name}
    echo -en "${green}Bridge Name:${def} "
    docker network inspect --format='{{ index .Options "com.docker.network.bridge.name" }}' ${net_name}
  fi
  echo -e "${green}Containers:${def}"
  docker network inspect -f '{{ range .Containers }}{{println .Name}}{{ end }}' ${net_name}
  echo
done

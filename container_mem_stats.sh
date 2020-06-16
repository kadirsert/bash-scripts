#!/usr/bin/env bash

tmp_out="$(mktemp)"
docker stats --no-stream |awk '{print $2";"$4}' 2> /dev/null |egrep '.*[0-9.]*(KiB|MiB|GiB).*' |sort -t ";" -k2 -gr > $tmp_out
egrep '.*[0-9.]*GiB.*' $tmp_out |sed 's/;/ -> /g'
egrep '.*[0-9.]*MiB.*' $tmp_out |sed 's/;/ -> /g'
egrep '.*[0-9.]*KiB.*' $tmp_out |sed 's/;/ -> /g'
rm -f $tmp_out

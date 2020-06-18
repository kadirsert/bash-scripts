#!/usr/bin/env bash

tmp_out="$(mktemp)"
docker stats --no-stream |awk '{print $2";"$3}' 2> /dev/null |egrep '.*[0-9.]*%$' |sort -t ";" -k2 -gr > $tmp_out
cat $tmp_out |sed 's/;/ -> /g'
rm -f $tmp_out

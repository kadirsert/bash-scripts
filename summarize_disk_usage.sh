#!/usr/bin/env bash

tmp_out="$(mktemp)"
du -skhx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.,]*[GMK]' | sort -nr > $tmp_out
egrep '^ *[0-9.,]*G' $tmp_out
egrep '^ *[0-9.,]*M' $tmp_out
egrep '^ *[0-9.,]*K' $tmp_out
rm -f $tmp_out

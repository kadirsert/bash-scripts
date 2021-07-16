#!/usr/bin/env bash

for i in $(ls /sys/class/scsi_host/)
do
  echo "/sys/class/scsi_host/$i/scan"
  echo "- - -" > /sys/class/scsi_host/$i/scan
done


#!/bin/bash

LOGFILE="logfile.log"

echo "---- Error Count ----"
awk '$3 >= 400 {count++} END {print count}' $LOGFILE

echo "---- Unique IPs ----"
awk '{print $1}' $LOGFILE | sort | uniq

echo "---- Masked Logs ----"
sed -E 's/^([0-9]+\.[0-9]+)\.[0-9]+\.[0-9]+/\1.xxx.xxx/' $LOGFILE

#!/bin/bash


######################################
#Author : Roy Ivia
#Date : 23/03/2026
#
#This script outputs the Node Health
#
#Version: V1
#####################################
#

#Set in debug mode
set -x

echo "Print the disk space"

df -h

echo "Print the memory"

free -g

echo "print the CPU"

nproc

echo "Show processes"

ps -ef

echo "Show Amazon processes"

ps -ef | grep "amazon"

echo "Amazon processes but case insensitive "

ps -ef | grep -i "amazon"

#Now it will match:
#amazon
#Amazon
#AMAZON
#AmaZon


#This command:
 ps -ef | grep amazon

#will also show the grep process itself, like: root     1234  ... grep amazon

#Option 1: exclude grep

ps -ef | grep -i "amazon" | grep -v grep

#Option 2 (BEST practice):

pgrep -af amazon

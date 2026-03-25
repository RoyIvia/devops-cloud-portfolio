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


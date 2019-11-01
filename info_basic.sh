#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf "\e[4mBasic System Information\e[0m\n"

case $1 in
	1)
		#Print free memory
		echo "Occupied and free memory in MB"
		free -m
		;;
	2)
		#Print free disk space
		echo -e "Occupied and free disk space\n"
	       	df -hx squashfs -x tmpfs --total
		;;
	3)
		#Print connection info
		echo -e "System Connection Info\n"
		ifconfig -a | grep -v "RX\|TX"
		;;
	4)
		#Print system load average
		echo -e "System Load Average\n"
		w
		;;
esac


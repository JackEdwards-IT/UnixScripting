#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf=/usr/bin/printf


#Hold script output on screen until user hits enter
go_back () {
	local choice	
	printf "\nPlease press Enter to return to main menu : "
	read choice
	case $choice in
		*)
			;;
	esac

}

#Script begins here
#case reads in argument passed in, outputs info and calls the go back method above
printf "\e[4mBasic System Information\e[0m\n"

case $1 in
	1)
		#Print free memory
		printf "Occupied and free memory in MB\n\n"
		free -m
		go_back 
		;;
	2)
		#Print free disk space
		printf "Occupied and free disk space\n\n"
	       	df -hx squashfs -x tmpfs --total
		go_back
		;;
	3)
		#Print connection info
		printf "System Connection Info\n\n"
		ifconfig -a | grep -v "RX\|TX"
		go_back
		;;
	4)
		#Print system load average
		printf "System Load Average\n\n"
		w
		go_back
		;;
esac


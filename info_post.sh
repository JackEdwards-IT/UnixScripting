#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

#get current user, used in options c and d.

printf "\e[4mBasic System Information with Post Processing\e[0m\n"
user="$(whoami)"

while getopts "abcde" c
do
	case $c in
		a) printf "Number of CPU cores on this system is: "
		       	nproc ;;
		b) echo "Current process priority is"
			p=$$
			
			ps -o pri -p $p
	  		;;
		c) printf "Number of processes running under current user "$user" is: " 
			ps -U "$user" | wc -l
			;;
		d) printf "Number of open file descriptors for user "$user" is: "
		       lsof -u "$user" |wc -l	
			printf "Number of open REGULAR files for user "$user" is: "
		       lsof -u "$user" | grep 'REG' | wc -l
	       	       ;;
	       e) printf "stack size is: "$(ulimit -s)"kB\n"
	esac
done

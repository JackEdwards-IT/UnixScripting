#!/bin/bash

while getopts "abcde" c
do
	case $c in
		a) printf "Number of CPU cores on this system is: "
		       	nproc ;;
		b) echo "Current process priority is"
			p=$$
			
			ps -o pri -p $p
	  		;;
		c) user="$(whoami)"
			printf "Number of processes running under current user "$user" is: " 
			ps -U "$user" | wc -l
			;;
		d) echo "d" ;;
		e) echo "e" ;;
	esac
done

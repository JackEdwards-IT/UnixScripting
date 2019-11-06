#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf=/usr/bin/printf
echo=/bin/echo

#Hold script output on screen until user hits enter
go_back () {
	local choice
	printf "\nPlease press Enter to return to main menu : "
	read -r choice
	case $choice in
		*)
			;;
	esac
}




#get current user, used in options c and d.
user="$(whoami)"

#Case statment for getopts options passed in
printf "\e[4mBasic System Information with Post Processing\e[0m\n"
while getopts "abcde" c
do
	case $c in
		a) printf "\nNumber of CPU cores on this system is: "
		       	nproc; go_back ;;

		b) printf "\nCurrent process priority is "
			p=$$
			ps -o pri -p $p
	  		go_back ;;

		c) printf "%s\nNumber of processes running under current user ""$user"" is: " 
			ps -U "$user" | wc -l
			go_back ;;

		d) printf "%s\nNumber of open file descriptors for user ""$user"" is: "
		       lsof -u "$user" |wc -l	
			printf "%s\nNumber of open REGULAR files for user ""$user"" is: "
		       lsof -u "$user" | grep -c 'REG'
	       	       go_back ;;

	       e) printf "%s\nstack size is: ""$(ulimit -s)""kB\n"
		       go_back ;;
	       
	       *) printf "Somthing went wrong with the input passed in.";go_back ;;       
	esac	

done

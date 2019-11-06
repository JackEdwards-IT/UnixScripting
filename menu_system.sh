#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf=/usr/bin/printf

#Disable CTRL C per spec
trap '' INT

#Submenu to call the basic information script passing in an argument
menu_one () {

	clear
	printf "Basic System Info\n"
	printf "=================\n"
	printf "1) View memory utilisation\n"
	printf "2) View disk utilisation\n"
	printf "3) View Network connection info\n"
	printf "4) View System load average\n"
	printf "b) Go back to previous menu\n"
	printf "\nEnter your selection: "

	local choice
	read -r choice
	
	#Arguments are simply read as $1 in remote script. Options are 1 through 4
	case $choice in
		1)	clear; sh ./info_basic.sh 1
			;;

		2) 	clear; sh ./info_basic.sh 2
			;;

		3) 	clear; sh ./info_basic.sh 3
			;;

		4)	clear; sh ./info_basic.sh 4
			;;

		(b | B) menu ;;

		*)	clear; printf "Invalid option. Valid options are 1,2,3,4, b"
			sleep 3; menu_one		

	esac
}

#submenu to call the basic info with post processing script passing in argument
menu_two () {

	clear
	printf "Advanced System Info\n"
	printf "=================\n"
	printf "1) View number of CPU cores\n"
	printf "2) View current process priority\n"
	printf "3) View number of processes running uder current user\n"
	printf "4) View number of open file descriptors for user\n"
	printf "5) View stack size\n"
	printf "b) Go back to main menu\n"
	printf "\nEnter your selection: "

	local choice
	read -r choice

	#Arguments are handled by getopts in remote script -a through -e
	case $choice in
		1)	clear; sh ./info_post.sh -a
			;;

		2) 	clear; sh ./info_post.sh -b
			;;

		3) 	clear; sh ./info_post.sh -c
			;;

		4)	clear; sh ./info_post.sh -d
			;;

		5)	clear; sh ./info_post.sh -e
			;;

		(b | B)	menu ;;

		*)	clear; printf "Invalid option. Valid options are 1,2,3,4, b"
			sleep 3; menu_two ;;		

	esac
}

#main menu

menu () {
	#clear
	printf "\e[4mMenu System\e[0m\n"
	printf "===========================\n"
	printf "1) Basic System Information\n"
	printf "2) Advanced System Information\n"
	printf "3) Find tool\n"
	printf "4) Basic Profiler (NOT IMPLEMENTED)\n"
	printf "q) Quit\n"
	printf "\nEnter your selection: "
	return
}

QUIT="0"
while [ "$QUIT" == "0" ]
do
	menu
	read -r choice

	# Cases 1 and 2 call submenus that then call appropriate script passing in arguments
	# 3 calls the find script directly

	# 4 has not been implemented
	case $choice in
		1) 	menu_one
			;;
		2)	menu_two
			;;

		3)	clear; sh ./find.sh
			;;

		4)	;;

		(q | Q)	QUIT="1"; printf "Goodbye"
			;;

		*)      clear
			printf "\n Invalid option. Valid options are 1,2,3,4 and q\n"
			sleep 2
			;;
	esac
done



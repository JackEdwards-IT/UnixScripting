#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf "\e[4mFind Script\e[0m\n"
printf "Please enter the directory the search should begin from\n"
read -p ":" searchdir

echo $searchdir

#Selection menu for thing to search for, simple while  case loop with input validationt	
printf "Please select the thing you are searching for\n"
printf "1 - path\n2 - type\n3 - group\n4 - fstype\n"

#Select what to search for
while read -p "enter a number beetween 1 and 4:" selection; do
	case "$selection" in
	
		1) searchitem="path"; break ;;
		2) searchitem="type"; break ;;
		3) searchitem="group"; break ;;
		4) searchitem="fstype"; break ;;
		*)echo "Incorect input, please enter a option from 1 to 4" ;;
	esac
done

echo $searchitem

#Specify searh value to apply to search term

echo "Please enter search term to apply to: "$searchitem""

read -p ":" -r searchvalue;

echo $searchvalue

#Prompt user if they would liek to specify search depth and wether to follow symbolic links or not.



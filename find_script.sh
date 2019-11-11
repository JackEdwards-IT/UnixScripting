#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf=/usr/bin/printf
echo=/bin/echo

#Script begins here, displays first option

start_find () {

	printf "\e[4mFind Script\e[0m\n"
	printf "Please enter the directory the search should begin from\n"
	read -r -p ":" searchdir
}
start_find

search_item () {

	#Selection menu for thing to search for, simple case loop with input validation

	printf "Please select the type of thing you are searching for\n"
	printf "1 -path\n2 -type\n3 -group\n4 -fstype\n"

	#Select what to search for
	while read -r -p "enter a number beetween 1 and 4:" selection; do
		case "$selection" in
		
			1) searchitem="-path "; break ;;
			2) searchitem="-type "; break ;;
			3) searchitem="-group "; break ;;
			4) searchitem="-fstype "; break ;;
			*)echo "Incorect input, please enter a option from 1 to 4" ;;
		esac
	done
}

search_item



search_parameters () {

#Specify searh value to apply to search term

	printf "%s\nPlease enter a value to apply to ""$searchitem"""
	printf ":\n"
	read -r searchvalue;

	searchparam="$searchitem$searchvalue"

	printf "\nPlease enter the value applied to the thing to search for (example: -name name)"
	printf "\nleave blank for none.\n"
	echo "Current input so far is: ""$searchdir"" ""$searchparam"""
	read -r extraparam
}

search_parameters

#Prompt user if they would like to specify search depth and wether to follow symbolic links or not.


search_depth () {
	local choice
	local input
	read -r -p "Would you like to specify max search depth (y/n)?" choice
	case "$choice" in
		y|Y ) read -r -p "Please specify search depth as an integer:" input
			maxdepth="-maxdepth ${input}";;
		n|N ) ;;
		* ) echo "Invalid choice"
		       search_depth;;
	esac
}
							
search_depth

#Prompt user if they would like to follow symbolic links or not

symboliclink=""

symbolic_links () {
	local choice
	read -r -p "Would you like to follow symbolic links (y/n)?" choice
	case "$choice" in
		y|Y ) echo "Following symbolic links"
			symboliclink="-L" ;;
		n|N )  ;;
		* ) echo "Invalid choice"
			symbolic_links;;
	esac
}

symbolic_links

#Prompt user as to what they want to do with search results

result_action () {
	local selection
	printf "Please select select the action you would like to take on the search result\n"
	printf "1 - delete\n2 - print\n3 - print0\n4 - custom\n"

	while read -r -p "enter a number beetween 1 and 4:" selection; do
		case "$selection" in
		
			1) action="-delete"; break ;;
			2) action="-print"; break ;;
			3) action="-print0"; break ;;
			4) action="-custom"; break ;;
			*) echo "Incorect input, please enter a option from 1 to 4" ;;
		esac
	done

}

result_action

#All inputs have been taken from the user, the search starts

perform_search () {

	searcharray=("$searchdir" "$symboliclink" "$maxdepth" "$searchparam" "$extraparam" "$action")
	findcmd="find ${searcharray[@]}"
	result="$($findcmd)"
	echo "$result"

	sleep 4
		
	local choice
	printf "\nPlease press Enter to return to main menu"
	read -r choice
	case $choice in
		*)
			;;
	esac
	

}


perform_search


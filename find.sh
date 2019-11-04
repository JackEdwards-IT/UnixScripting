#!/bin/bash

#Created by Jack Edwards
#RMIT student number S3727853

printf=/usr/bin/printf
echo=/bin/echo

#Script begins here, displays first option

start_find () {

	printf "\e[4mFind Script\e[0m\n"
	printf "Please enter the directory the search should begin from\n"
	read -p ":" searchdir

	echo $searchdir
}
start_find

search_item () {

	#Selection menu for thing to search for, simple case loop with input validationt

	printf "Please select the type of thing you are searching for\n"
	printf "1 -path\n2 -type\n3 -group\n4 -fstype\n"

	#Select what to search for
	while read -p "enter a number beetween 1 and 4:" selection; do
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

echo $searchitem

search_parameters () {

#Specify searh value to apply to search term

	printf "\nPlease enter a value to apply to "$searchitem""
	printf ":\n"
	read -r searchvalue;

	searchparam="$searchitem $searchvalue"

	printf "\nPlease enter extra search parameters to apply to current search if any.\nleave blank for none.\n"
	echo "Current input so far is: "$searchdir $searchparam""

	read -r extraparam

	echo $extraparam
}

search_parameters
#Prompt user if they would like to specify search depth and wether to follow symbolic links or not.


search_depth () {
	local choice
	local input
	read -p "Would you like to specify max search depth (y/n)?" choice
	echo $choice
	case "$choice" in
		y|Y ) read -p "Please specify search depth as an integer:" input
			maxdepth="-maxdepth ${input}";;
		n|N ) ;;
		* ) echo "Invalid choice"
		       search_depth;;
	esac
}
							
search_depth

symboliclink=""

symbolic_links () {
	local choice
	read -p "Would you like to follow symbolic links (y/n)?" choice
	case "$choice" in
		y|Y ) echo "Following symbolic links"
			symboliclink="-L" ;;
		n|N )  ;;
		* ) echo "Invalid choice"
			symbolic_links;;
	esac
}

symbolic_links

result_action () {
	local selection
	printf "Please select select the action you would like to take on the search result\n"
	printf "1 - delete\n2 - print\n3 - print0\n4 - custom\n"

	while read -p "enter a number beetween 1 and 4:" selection; do
		case "$selection" in
		
			1) action="-delete"; break ;;
			2) action="-print"; break ;;
			3) action="-print0"; break ;;
			4) action="-custom"; break ;;
			*)echo "Incorect input, please enter a option from 1 to 4" ;;
		esac
	done

}

result_action

#All inputs have been taken from the user, the search starts

perform_search () {

	find "$searchdir" $symboliclink $maxdepth $searchparam $extraparam $action
	echo "$searchdir" "$symboliclink" "$maxdepth" "$searchparam" "$extraparam" "$action"

	if [ $? -gt 0 ]
	then
		echo "It appears somthing went wrong, would you like to start again?"
		local choice
		read choice

		case "$choice" in
		y|Y ) start_find ;;
		n|N )  ;;
		* ) echo "Invalid choice"
			perform_search;;
	esac
	fi

}


perform_search


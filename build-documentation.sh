#!/bin/bash

echo "This script will install man pages to your system"
echo "It will require root access so please allow it if prompted"

#create folder for pages
sudo mkdir /usr/local/share/man/man1

#copy man pages
sudo cp find_script.1.gz info_basic.1.gz info_post.1.gz menu_system.1.gz /usr/local/share/man/man1

#Run mandb which should detect and install man pages
sudo mandb

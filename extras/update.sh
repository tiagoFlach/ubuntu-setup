#!/bin/bash

# author: Tiago Lucas Flach
# https://github.com/tiagoFlach


# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLDBLUE='\033[1;34m'
NC='\033[0m'        	# No Color


OS_RELEASE_ID=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2- | sed 's|"||g')


if [ "$OS_RELEASE_ID" == "ubuntu" ]; then
	echo -e "\n\n${YELLOW}sudo apt update ${NC}\n"
	sudo apt --fix-missing update && sudo apt list --upgradable

	echo -e "\n\n${YELLOW}sudo apt dist-upgrade ${NC}\n"
	sudo apt dist-upgrade -y
elif [ "$OS_RELEASE_ID" == "fedora" ]; then
	echo -e "\n\n${YELLOW}sudo dnf update ${NC}\n"
	sudo dnf update -y
fi

echo -e "\n\n${YELLOW}sudo snap refresh ${NC}\n"
sudo snap refresh

echo -e "\n\n${YELLOW}sudo flatpak update ${NC}\n"
sudo flatpak update -y

# echo -e "\n\n${YELLOW}sudo flatpak uninstall --unused ${NC}\n"
# sudo flatpak uninstall --unused -y

echo -e "\n\n${YELLOW}sudo apt autoremove ${NC}\n"
sudo apt autoremove -y

echo -e "\n\n${YELLOW}sudo apt autoclean ${NC}\n"
sudo apt autoclean
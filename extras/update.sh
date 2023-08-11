#!/bin/bash

# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLDBLUE='\033[1;34m'
NC='\033[0m' # No Color

OS_RELEASE_ID=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2- | sed 's|"||g')

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then

	SNAP_SUPPORT=$(dpkg -l | grep -q snapd)
	FLATPAK_SUPPORT=$(dpkg -l | grep -q flatpak)

	while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
		sleep 1
	done

	echo -e "\n\n${YELLOW}sudo apt update ${NC}\n"
	sudo apt update --fix-missing && sudo apt list --upgradable

	echo -e "\n\n${YELLOW}sudo apt dist-upgrade ${NC}\n"
	sudo apt dist-upgrade -y

	upgradable_packages=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")
	if [[ -n $upgradable_packages ]]; then
		packages=$(echo "$upgradable_packages" | cut -d'/' -f1)

		sudo apt install $packages -y
	fi

	echo -e "\n\n${YELLOW}sudo ubuntu-drivers autoinstall ${NC}\n"
	sudo ubuntu-drivers autoinstall
elif [ "$OS_RELEASE_ID" == "fedora" ]; then

	SNAP_SUPPORT=$(rpm -qa | grep -q snapd)
	FLATPAK_SUPPORT=$(rpm -qa | grep -q flatpak)

	echo -e "\n\n${YELLOW}sudo dnf update ${NC}\n"
	sudo dnf update -y
fi

if $SNAP_SUPPORT; then
	echo -e "\n\n${YELLOW}sudo snap refresh ${NC}\n"
	sudo snap refresh
fi

if $FLATPAK_SUPPORT; then
	echo -e "\n\n${YELLOW}sudo flatpak update ${NC}\n"
	sudo flatpak update -y

	echo -e "\n\n${YELLOW}sudo flatpak uninstall --unused ${NC}\n"
	sudo flatpak uninstall --unused -y
fi

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then
	echo -e "\n\n${YELLOW}sudo apt autoremove ${NC}\n"
	sudo apt autoremove -y

	echo -e "\n\n${YELLOW}sudo apt autoclean ${NC}\n"
	sudo apt autoclean
fi

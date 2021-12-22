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



echo -e "\n\n${YELLOW}sudo apt-get update ${NC}\n"
sudo apt-get update && sudo apt list --upgradable

echo -e "\n\n${YELLOW}sudo apt-get dist-upgrade ${NC}\n"
sudo apt-get dist-upgrade -y

echo -e "\n\n${YELLOW}sudo apt-get repair ${NC}\n"
sudo flatpak repair

echo -e "\n\n${YELLOW}sudo flatpak update ${NC}\n"
sudo flatpak update -y

echo -e "\n\n${YELLOW}sudo flatpak uninstall --unused ${NC}\n"
sudo flatpak uninstall --unused -y

echo -e "\n\n${YELLOW}sudo flatpak repair ${NC}\n"
sudo flatpak repair

echo -e "\n\n${YELLOW}sudo snap refresh ${NC}\n"
sudo snap refresh

echo -e "\n\n${YELLOW}sudo apt autoclean ${NC}\n"
sudo apt autoclean

echo -e "\n\n${YELLOW}sudo apt-get autoremove ${NC}\n"
sudo apt-get autoremove -y

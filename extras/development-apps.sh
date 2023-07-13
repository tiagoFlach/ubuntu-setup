#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Android Studio
# 	Atom
# 	Composer
#	Eclipse
#	DBeaver
# 	Docker
# 	Filezilla
#	Git
#	GitHub CLI
# 	GitKraken
#	InteliJ
#	Insomnia
#	MySQL Workbench
# 	NodeJs
# 	NPM
# 	PhpStorm
# 	Postman
# 	Python Pip
# 	Sublime Text
# 	Sublime Merge
# 	Visual Studio Code

APPS=(
	"android-studio"
	"atom"
	"composer"
	"eclipse"
	"dbeaver"
	"docker"
	"filezilla"
	"git"
	"gh"
	"gitkraken"
	"intellij"
	"insomnia"
	"mysql-workbench"
	"nodejs"
	"npm"
	"phpstorm"
	"postman"
	"python3-pip"
	"sublime-text"
	"sublime-merge"
	"code"
)
APPS=$(echo ${APPS[@]} | tr ' ' '\n' | sort | tr '\n' ' ')


if ! which curl >/dev/null; then
	sudo apt install curl -y -q
fi


# Android Studio
# --------------------------------------
android_studio() {
	sudo snap install android-studio --classic -y
}


# Atom
# --------------------------------------
atom() {
	if [ ! -f "/usr/share/keyrings/atom-keyring.gpg" ]; then
		wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/atom-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/atom-keyring.gpg] https://packagecloud.io/AtomEditor/atom/any/ any main" | sudo tee /etc/apt/sources.list.d/atom.list
	fi

	sudo apt update
	sudo apt install atom -y
}


# Composer
# --------------------------------------
composer() {
	sudo apt install composer -y
}


# Eclipse
# --------------------------------------
eclipse() {
	# sudo snap install eclipse --classic
	flatpak install flathub org.eclipse.Java -y
}


# DBeaver
# --------------------------------------
dbeaver() {
	flatpak install flathub io.dbeaver.DBeaverCommunity
}


# Docker
# --------------------------------------
docker() {
	# Prerequisite packages
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	# Then add the GPG key for the official Docker repository to your system:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	# Add the Docker repository to APT sources:
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	apt-cache policy docker-ce
	sudo apt install docker-ce -y

	# Post-installation steps for Linux
	sudo groupadd docker
	sudo usermod -aG docker $USER
}


# Git
# --------------------------------------
git() {
	sudo apt-add-repository ppa:git-core/ppa -y
	sudo apt install git -y
	git config --global user.email "tiagolucas9830@gmail.com"
	git config --global user.name "Tiago Lucas Flach"
}


# GitHub CLI
# --------------------------------------
gh() {
	if [ ! -f "/usr/share/keyrings/githubcli-archive-keyring.gpg" ]; then
		curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
		sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	fi

	sudo apt update
	sudo apt install gh -y
}


# GitKraken
# --------------------------------------
gitkraken() {
	sudo snap install gitkraken --classic -y
}


# IntelliJ
# --------------------------------------
intellij() {
	sudo snap install intellij-idea-community --classic -y
}


# Insomnia
# --------------------------------------
insomnia() {
	flatpak install flathub rest.insomnia.Insomnia -y
}


# Mysql Workbench
# --------------------------------------
mysql_workbench() {
	sudo snap install mysql-workbench-community -y
}

# NodeJs
# --------------------------------------
nodejs() {
	sudo apt install nodejs -y
}


# NPM
# --------------------------------------
npm() {
	sudo apt install npm -y

	sudo npm cache clean -f
	sudo npm install -g npm
	sudo n stable
}


# PhpStorm
# --------------------------------------
phpstorm() {
	sudo snap install phpstorm --classic -y
}


# Postman
# --------------------------------------
postman() {
	flatpak install flathub com.getpostman.Postman -y
}


# Python Pip
# --------------------------------------
python_pip() {
	sudo apt install python3-pip -y
}


# Subllime Text
# --------------------------------------
sublime_text() {
	if [ ! -f "/usr/share/keyrings/sublimetext-keyring.gpg" ]; then
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/sublimetext-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	fi

	sudo apt update
	sudo apt install sublime-text -y
}


# Sublime Merge
# --------------------------------------
sublime_merge() {
	sudo apt install sublime-merge -y
}


# Visual Studio Code
# --------------------------------------
code() {
	sudo apt install wget gpg apt-transport-https -y
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	sudo apt install code -y
	# sudo snap install code --classic
}


# FileZilla
# --------------------------------------
filezilla() {
	sudo apt install filezilla -y
}



# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLDBLUE='\033[1;34m'
NC='\033[0m'        # No Color

if ! which curl >/dev/null; then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
	sudo apt update && sudo apt install gum
fi

select_apps() {
	gum choose --no-limit --height ${#APPS[@]} ${APPS}
}

echo "Selecione quais aplicativos deseja instalar:"
SELECTED=$(select_apps)

# Install selected apps
# --------------------------------------
for app in ${SELECTED[@]}; do
	echo -e "\n\n${YELLOW}	[INSTALANDO] - $app ${NC}\n\n"
	$(echo $app | sed 's/-/_/g' | tr '[:upper:]' '[:lower:]')
done
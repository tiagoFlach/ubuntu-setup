#!/usr/bin/env bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Android Studio
# 	Atom
#	Eclipse
#	DBeaver
#	Git
#	GitHub CLI
# 	GitKraken
# 	NodeJs
# 	NPM
# 	PhpStorm
# 	Postman
# 	Python Pip
# 	Sublime Text
# 	Sublime Merge
# 	Visual Studio Code

# Android Studio
# --------------------------------------
sudo apt install curl -y -q


# Android Studio
# --------------------------------------
sudo snap install android-studio --classic


# Atom
# --------------------------------------
if [ ! -f "/usr/share/keyrings/atom-keyring.gpg" ]; then
	wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/atom-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/atom-keyring.gpg] https://packagecloud.io/AtomEditor/atom/any/ any main" | sudo tee /etc/apt/sources.list.d/atom.list
fi

sudo apt update
sudo apt install atom -y


# Eclipse
# --------------------------------------
# sudo snap install eclipse --classic
flatpak install flathub org.eclipse.Java


# DBeaver
# --------------------------------------
flatpak install flathub io.dbeaver.DBeaverCommunity


## Git
# --------------------------------------
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt install git -y
git config --global user.email "tiagolucas9830@gmail.com"
git config --global user.name "Tiago Lucas Flach"


## GitHub CLI
# --------------------------------------
if [ ! -f "/usr/share/keyrings/githubcli-archive-keyring.gpg" ]; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi

sudo apt update
sudo apt install gh


# GitKraken
# --------------------------------------
sudo snap install gitkraken --classic


# NodeJs
# --------------------------------------
sudo apt install nodejs -y


# NPM
# --------------------------------------
sudo apt install npm -y

sudo npm cache clean -f
sudo npm install -g npm
sudo n stable


# Php Storm
# --------------------------------------
sudo snap install phpstorm --classic


# Python Pip
# --------------------------------------
sudo apt install python3-pip


# Subllime Text
# --------------------------------------
if [ ! -f "/usr/share/keyrings/sublimetext-keyring.gpg" ]; then
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/sublimetext-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi

sudo apt update
sudo apt install sublime-text -y


# Sublime Merge
# --------------------------------------
sudo apt install sublime-merge -y


# Visual Studio Code
# --------------------------------------
sudo apt-get install wget gpg apt-transport-https -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install code -y
# sudo snap install code --classic


# --------------------------------------
## FileZilla ##
# sudo apt install filezilla -y

## Composer ##
# sudo apt install composer -y

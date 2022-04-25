#!/usr/bin/env bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Android Studio;
# 	Atom;
#	Eclipse
#	Git
#	GitHub CLI
# 	GitKraken;
# 	NodeJs;
# 	NPM;
# 	PhpStorm;
# 	Sublime Text;
# 	Sublime Merge;
# 	Visual Studio Code;

# Android Studio
# --------------------------------------
sudo apt install curl


# Android Studio
# --------------------------------------
sudo snap install android-studio --classic


# Atom
# --------------------------------------
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/atom-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/atom-keyring.gpg] https://packagecloud.io/AtomEditor/atom/any/ any main" | sudo tee /etc/apt/sources.list.d/atom.list

sudo apt update
sudo apt install atom -y


# Eclipse
# --------------------------------------
sudo snap install eclipse --classic


## Git
# --------------------------------------
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt install git -y
git config --global user.email "tiagolucas9830@gmail.com"
git config --global user.name "Tiago Lucas Flach"


## GitHub CLI
# --------------------------------------
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

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


# Subllime Text
# --------------------------------------
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/sublimetext-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt update
sudo apt install sublime-text -y


# Sublime Merge
# --------------------------------------
sudo apt install sublime-merge -y


# Visual Studio Code
# --------------------------------------
sudo snap install code --classic


# --------------------------------------
## FileZilla ##
# sudo apt install filezilla -y

## Composer ##
# sudo apt install composer -y

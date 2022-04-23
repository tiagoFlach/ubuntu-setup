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
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

sudo apt-get update
sudo apt-get install atom -y


# Eclipse
# --------------------------------------
sudo snap install eclipse --classic


## Git
# --------------------------------------
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt-get install git -y
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
sudo apt-get install nodejs -y


# NPM
# --------------------------------------
sudo apt-get install npm -y

sudo npm cache clean -f
sudo npm install -g npm
sudo n stable


# Php Storm
# --------------------------------------
sudo snap install phpstorm --classic


# Subllime Text
# --------------------------------------
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-text -y


# Sublime Merge
# --------------------------------------
sudo apt-get install sublime-merge -y


# Visual Studio Code
# --------------------------------------
sudo snap install code --classic


# --------------------------------------
## FileZilla ##
# sudo apt-get install filezilla -y

## Composer ##
# sudo apt-get install composer -y

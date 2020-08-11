#!/usr/bin/env bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Atom;
# 	GitKraken;
# 	NodeJs;
# 	NPM;
# 	PhpStorm;
# 	Sublime Text;
# 	Sublime Merge;
# 	Visual Studio Code;


# Atom
# --------------------------------------
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

sudo apt-get update
sudo apt-get install atom -y


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
sudo npm install -g n
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

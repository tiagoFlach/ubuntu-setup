#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Atom;
# 	GitKraken;
# 	PhpStorm;
# 	Sublime Text;
# 	Sublime Merge;
# 	Visual Studio Code;


# Atom
# --------------------------------------
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

sudo apt update
sudo apt install atom -y


# GitKraken
# --------------------------------------
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
sudo apt install -f -y
rm gitkraken-amd64.deb

sudo apt update


# Php Storm
# --------------------------------------
sudo snap install phpstorm --classic


# Subllime Text
# --------------------------------------
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt update
sudo apt install sublime-text -y


# Sublime Merge
# --------------------------------------
sudo apt-get install sublime-merge -y


# Visual Studio Code
# --------------------------------------
sudo snap install code --classic


# --------------------------------------
## FileZilla ##
# sudo apt install filezilla -y

## Composer ##
# sudo apt install composer -y

## Npm ##
# sudo apt install npm -y
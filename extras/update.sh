#!/bin/bash

# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

sudo apt-get update && sudo apt list --upgradable
sudo apt-get dist-upgrade -y
sudo flatpak update -y
sudo flatpak repair
sudo snap refresh
sudo apt autoclean
sudo apt-get autoremove -y

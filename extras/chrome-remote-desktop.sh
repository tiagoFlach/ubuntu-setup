#!/usr/bin/env bash

# https://kmyers.me/blog/linux/chrome-remote-desktop-on-ubuntu-20-04-setup-guide-setup-script/

cd ~/

sudo apt install -y wget && bash <(wget -qO- https://raw.githubusercontent.com/KeithIMyers/Chrome-Remote-Desktop-Ubuntu-Setup/master/chrome-remote-desktop-setup.sh);
#!/bin/bash
# File: extras/chrome-remote-desktop.sh
# Author: Tiago Lucas Flach

source "$(dirname -- "${BASH_SOURCE[0]}")/../core/os.sh"
require_distro ubuntu || exit 1

# https://kmyers.me/blog/linux/chrome-remote-desktop-on-ubuntu-20-04-setup-guide-setup-script/

cd ~/

sudo apt install -y wget && bash <(wget -qO- https://raw.githubusercontent.com/KeithIMyers/Chrome-Remote-Desktop-Ubuntu-Setup/master/chrome-remote-desktop-setup.sh)

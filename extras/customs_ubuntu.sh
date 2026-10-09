#!/bin/bash
# File: extras/customs_ubuntu.sh
# Author: Tiago Lucas Flach

if [[ ! -r /etc/os-release ]]; then
	echo "Não foi possível detectar a distribuição Linux."
	exit 1
fi
. /etc/os-release
if [[ "${ID:-}" != "ubuntu" ]]; then
	echo "Este script de personalização é exclusivo para Ubuntu."
	exit 1
fi

# Desktop Icons
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding show-trash false

# Interface
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'

# Mutter
gsettings set org.gnome.mutter workspaces-only-on-primary false

# Sound
gsettings set org.gnome.shell.ubuntu startup-sound ''
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true

# Hidden Folders
touch "$HOME/.hidden"
grep -qxF "snap" "$HOME/.hidden" || printf '%s\n' "snap" >>"$HOME/.hidden"

# Tiling Assistant
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tiling-popup true

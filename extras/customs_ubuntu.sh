#!/bin/bash

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
echo "snap" >>~/.hidden

# Tiling Assistant
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tiling-popup true

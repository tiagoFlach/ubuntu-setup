#!/bin/bash

source "${BASH_SOURCE%/*}/messages/updating_text.sh"

FILE_FLATPAK="${BASH_SOURCE%/*}/../data/apps_flatpak.txt"
APPS_FLATPAK=$(grep -Ev '^\s*#|^\s*$' "$FILE_FLATPAK")

# Install Flathub support
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak applications
flatpak install flathub -y $APPS_FLATPAK

updating_text "FLATPAK"
flatpak update -y
flatpak repair

#!/bin/bash
# File: core/install_flatpak.sh
# Author: Tiago Lucas Flach

source "${BASH_SOURCE%/*}/messages/updating_text.sh"

FILE_FLATPAK="${BASH_SOURCE%/*}/../data/apps_flatpak.txt"
mapfile -t APPS_FLATPAK < <(grep -Ev '^[[:space:]]*(#|$)' "$FILE_FLATPAK")

# Install Flathub support
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak applications
flatpak install flathub -y "${APPS_FLATPAK[@]}"

updating_text "FLATPAK"
flatpak update -y
flatpak repair

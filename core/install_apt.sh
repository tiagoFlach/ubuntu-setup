#!/bin/bash
# File: core/install_apt.sh
# Author: Tiago Lucas Flach

source "${BASH_SOURCE%/*}/messages/installing_text.sh"
source "${BASH_SOURCE%/*}/messages/updating_text.sh"

FILE_APT="${BASH_SOURCE%/*}/../data/apps_apt.txt"
mapfile -t APPS_APT < <(grep -Ev '^[[:space:]]*(#|$)' "$FILE_APT")

# Update APT packages
updating_text "APT"
sudo apt update && sudo apt full-upgrade -y

for app in "${APPS_APT[@]}"; do
    if ! dpkg-query -W -f='${db:Status-Status}' "$app" 2>/dev/null | grep -qx 'installed'; then
        installing_text "$app"

        sudo apt install -y "$app"
    fi
done

# Update APT packages
updating_text "APT"
sudo apt update && sudo apt full-upgrade -y
sudo apt -y autoremove

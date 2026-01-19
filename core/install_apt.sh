#!/bin/bash

source "${BASH_SOURCE%/*}/messages/installing_text.sh"
source "${BASH_SOURCE%/*}/messages/updating_text.sh"

FILE_APT="${BASH_SOURCE%/*}/../data/apps_apt.txt"
APPS_APT=$(grep -Ev '^\s*#|^\s*$' "$FILE_APT")

# Update APT packages
updating_text "APT"
sudo apt update && sudo apt upgrade -y

for app in ${APPS_APT[@]}; do
    if ! rpm -q "$app" &>/dev/null; then
        installing_text "$app"

        sudo apt install -y "$app"
    fi
done

# Update APT packages
updating_text "APT"
sudo apt update && sudo apt upgrade -y
sudo apt -y autoremove

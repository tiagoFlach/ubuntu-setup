#!/bin/bash

source "${BASH_SOURCE%/*}/messages/installing_text.sh"
source "${BASH_SOURCE%/*}/messages/updating_text.sh"

FILE_DNF="${BASH_SOURCE%/*}/../data/apps_dnf.txt"
APPS_DNF=$(grep -Ev '^\s*#|^\s*$' "$FILE_DNF")

# Update DNF packages
updating_text "DNF"
sudo dnf -y upgrade --refresh

for app in ${APPS_DNF[@]}; do
    if ! rpm -q "$app" &>/dev/null; then
        installing_text "$app"

        sudo dnf install -y "$app"
    fi
done

# Update DNF packages
updating_text "DNF"
sudo dnf -y upgrade --refresh
sudo dnf -y autoremove
sudo dnf -y clean all

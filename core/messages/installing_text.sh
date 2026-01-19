#!/bin/bash

source "${BASH_SOURCE%/*}/../colors.sh"
source "${BASH_SOURCE%/*}/../components.sh"

installing_text() {
    # Function to display the installation text
    # Arguments:
    #   $1 - The name of the application being installed
    local app="$1"

    # Display the installation message
    echo -e "\n\n${YELLOW}"$LINE1
    echo -e "	INSTALANDO: $app ${NC}"
    echo -e "${YELLOW}"$LINE1"${NC}\n"
}

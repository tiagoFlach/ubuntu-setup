#!/bin/bash

source "${BASH_SOURCE%/*}/../colors.sh"
source "${BASH_SOURCE%/*}/../components.sh"

updating_text() {
    # Function to display the installation text
    # Arguments:
    #   $1 - The name of service
    local service="$1"

    # Display the installation message
    echo -e "\n\n${CYAN}"$LINE1
    echo -e "	ATUALIZANDO $service ${NC}"
    echo -e "${CYAN}"$LINE1"${NC}\n"
}

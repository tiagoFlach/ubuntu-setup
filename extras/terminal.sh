#!/bin/bash

# Verifique se o zsh está instalado
if ! command -v zsh &> /dev/null
then
    installation
    
    # Adicione o script para ser executado na inicialização
    sudo cp ./extras/terminal.sh /etc/init.d/
    sudo update-rc.d script.sh defaults
    
    # Reinicie o computador
    # sudo reboot
    systemctl restart gdm
else
    configuration
    
    # Remova o script da lista de programas iniciados com o sistema
    sudo update-rc.d -f script.sh remove
fi


# Script inicial
installation() {
    ./extras/terminal1.sh
}

# Segundo script
configuration() {
    gnome-terminal -- bash ./extras/terminal2.sh
}

# Personalizaçoes
customs() {
}
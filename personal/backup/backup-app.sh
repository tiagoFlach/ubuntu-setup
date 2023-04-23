#!/bin/bash

backupPath=$(dirname "$(readlink -f "$0")")

if [ $# -lt 1 ]; then
    echo "Por favor, informe o parâmetro 'backup' ou 'restore'"
    exit 1
fi

if [ "$1" = "backup" ]; then
    # Backup
    # ----------

    # Profile picture
    cp -f /var/lib/AccountsService/icons/tiago $backupPath/

    # Shortwave
    cp -f ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave/Shortwave.db $backupPath/

    # Extensions
    cp -f -r ~/.local/share/gnome-shell/extensions $backupPath/

    echo "Backup concluído com sucesso."
elif [ "$1" = "restore" ]; then
    # Restore
    # ----------

    # Profile picture
    sudo cp -f $backupPath/tiago /var/lib/AccountsService/icons/

    # Shortwave
    cp -f $backupPath/Shortwave.db ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave/

    # Extensions
    cp -f -r $backupPath/extensions ~/.local/share/gnome-shell/

    echo "Restauração concluída com sucesso."
else
    echo "Opção inválida. Por favor, informe o parâmetro 'backup' ou 'restaurar'."
    exit 1
fi



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

	# Desktop app folders
	dconf dump /org/gnome/desktop/app-folders/ > $backupPath/app-folders.dconf

	echo "Backup concluído com sucesso."
elif [ "$1" = "restore" ]; then
	# Restore
	# ----------

	# Profile picture
	sudo cp -f $backupPath/tiago /var/lib/AccountsService/icons/
	sudo sed -i 's/\(Icon=\).*/\1\/var\/lib\/AccountsService\/icons\/tiago/' /var/lib/AccountsService/users/tiago

	# Shortwave
	# mkdir -p ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave
	cp -f $backupPath/Shortwave.db ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave/

	# Extensions
	cp -f -r $backupPath/extensions ~/.local/share/gnome-shell/

	# Desktop app folders
	dconf load /org/gnome/desktop/app-folders/ < $backupPath/app-folders.dconf

	echo "Restauração concluída com sucesso."
elif [ "$1" = "reset" ]; then
	# Reset
	# ----------

	# Profile picture
	# Shortwave
	# Extensions

	# Desktop app folders
	dconf reset /org/gnome/desktop/app-folders/

	echo "Reset concluído com sucesso."

else
	echo "Opção inválida. Por favor, informe o parâmetro 'backup' ou 'restaurar'."
	exit 1
fi

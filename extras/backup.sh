#!/bin/bash

backupPath=$(dirname "$(dirname "$(readlink -f "$0")")")/personal/backup

if [ $# -lt 1 ]; then
	echo "Por favor, informe o parâmetro 'backup', 'restore' ou 'reset'"
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
	cp -f -r ~/.local/share/gnome-shell/extensions/* $backupPath/extensions

	# Desktop app folders
	dconf dump /org/gnome/desktop/app-folders/ >$backupPath/app-folders.dconf

	# System connections
	sudo cp -f -p /etc/NetworkManager/system-connections/* $backupPath/system-connections/
	sudo chmod 665 $backupPath/system-connections/*

	# Remmina
	mkdir -p $backupPath/remmina
	sudo cp -r ~/.local/share/remmina/* $backupPath/remmina/

	# Apps
	# ----------
	date=$(date +"%Y-%m-%d")
	os=$(lsb_release -r | awk '{print $2}')

	# deb
	dpkg-query -W -f='${Package}\n' | sort >"$backupPath/apps/deb_${os}_$date.txt"

	# flatpak
	flatpak list --app --columns=application >"$backupPath/apps/flatpak_${os}_$date.txt"

	# snap
	snap list | awk 'NR>1 {print $1}' >"$backupPath/apps/snap_${os}_$date.txt"

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
	dconf load /org/gnome/desktop/app-folders/ <$backupPath/app-folders.dconf

	# System connections
	sudo cp -f -p $backupPath/system-connections/* /etc/NetworkManager/system-connections/
	sudo chown root:root /etc/NetworkManager/system-connections/*
	sudo chmod 600 /etc/NetworkManager/system-connections/*

	# Remmina
	mkdir -p ~/.local/share/remmina
	sudo cp -r -p $backupPath/remmina/* ~/.local/share/remmina/

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

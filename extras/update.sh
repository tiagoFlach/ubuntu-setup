#!/bin/bash

# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

source "${BASH_SOURCE%/*}/../core/colors.sh"

OS_RELEASE_ID=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2- | sed 's|"||g')

# Define o arquivo de controle
FLATPAK_CONTROL_FILE="$HOME/.flatpak_repair_last_run"

# Obtém a data atual no formato YYYY-WW (ano-semana)
CURRENT_WEEK=$(date +%Y-%V)

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then

	SNAP_SUPPORT=$(dpkg -l | grep -q snapd)
	FLATPAK_SUPPORT=$(dpkg -l | grep -q flatpak)

	while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
		sleep 1
	done

	echo -e "\n\n${YELLOW}sudo apt update ${NC}\n"
	sudo apt update --fix-missing && sudo apt list --upgradable

	echo -e "\n\n${YELLOW}sudo apt dist-upgrade ${NC}\n"
	sudo apt dist-upgrade -y

	upgradable_packages=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | grep -v "Listagem...")
	if [[ -n $upgradable_packages ]]; then
		packages=$(echo "$upgradable_packages" | cut -d'/' -f1)

		sudo apt install $packages -y
	fi

	# echo -e "\n\n${YELLOW}sudo ubuntu-drivers autoinstall ${NC}\n"
	# sudo ubuntu-drivers autoinstall
elif [ "$OS_RELEASE_ID" == "fedora" ]; then

	SNAP_SUPPORT=$(rpm -qa | grep -q snapd)
	FLATPAK_SUPPORT=$(rpm -qa | grep -q flatpak)

	echo -e "\n\n${YELLOW}sudo dnf upgrade ${NC}\n"
	sudo dnf upgrade -y --refresh
fi

if $SNAP_SUPPORT; then
	echo -e "\n\n${YELLOW}sudo snap refresh ${NC}\n"
	sudo snap refresh

	# Removes old revisions of snaps
	snap list --all | awk '/disabled/{print $1, $3}' |
		while read $snapname revision; do
			sudo snap remove "$snapname" --revision="$revision"
		done
fi

if $FLATPAK_SUPPORT; then
	echo -e "\n\n${YELLOW}sudo flatpak update ${NC}\n"
	sudo flatpak update -y

	echo -e "\n\n${YELLOW}sudo flatpak uninstall --unused ${NC}\n"
	sudo flatpak uninstall --unused -y

	# Garante que o arquivo de controle exista
	if [[ ! -f "$FLATPAK_CONTROL_FILE" ]]; then
		echo "" >"$FLATPAK_CONTROL_FILE"
	fi

	# Lê a última execução
	LAST_RUN=$(cat "$FLATPAK_CONTROL_FILE")

	# Se a última execução for diferente da semana atual, executa o comando
	if [[ "$LAST_RUN" != "$CURRENT_WEEK" ]]; then
		echo -e "\n\n${YELLOW}sudo flatpak repair ${NC}\n"
		sudo flatpak repair
		echo "$CURRENT_WEEK" >"$FLATPAK_CONTROL_FILE"
	fi
fi

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then
	echo -e "\n\n${YELLOW}sudo apt autoremove ${NC}\n"
	sudo apt autoremove -y

	echo -e "\n\n${YELLOW}sudo apt autoclean ${NC}\n"
	sudo apt autoclean
fi

#!/bin/bash
# File: extras/update.sh
# Author: Tiago Lucas Flach

# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/core/colors.sh"

if [[ ! -r /etc/os-release ]]; then
	echo "Não foi possível detectar a distribuição Linux."
	exit 1
fi
. /etc/os-release
OS_RELEASE_ID="${ID:-}"
if [[ "$OS_RELEASE_ID" != "ubuntu" && "$OS_RELEASE_ID" != "fedora" ]]; then
	echo "Distribuição não suportada: ${PRETTY_NAME:-$OS_RELEASE_ID}."
	exit 1
fi

SNAP_SUPPORT=false
FLATPAK_SUPPORT=false
command -v snap >/dev/null 2>&1 && SNAP_SUPPORT=true
command -v flatpak >/dev/null 2>&1 && FLATPAK_SUPPORT=true

# Define o arquivo de controle
FLATPAK_CONTROL_FILE="$HOME/.flatpak_repair_last_run"

# Obtém a data atual no formato YYYY-WW (ano-semana)
CURRENT_WEEK=$(date +%Y-%V)

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then

	while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
		sleep 1
	done

	echo -e "\n\n${YELLOW}sudo apt update ${NC}\n"
	sudo apt update --fix-missing && sudo apt list --upgradable

	echo -e "\n\n${YELLOW}sudo apt full-upgrade ${NC}\n"
	sudo apt full-upgrade -y

	# echo -e "\n\n${YELLOW}sudo ubuntu-drivers autoinstall ${NC}\n"
	# sudo ubuntu-drivers autoinstall
elif [ "$OS_RELEASE_ID" == "fedora" ]; then

	echo -e "\n\n${YELLOW}sudo dnf upgrade ${NC}\n"
	sudo dnf upgrade -y --refresh
fi

if $SNAP_SUPPORT; then
	echo -e "\n\n${YELLOW}sudo snap refresh ${NC}\n"
	sudo snap refresh

	# Removes old revisions of snaps
	snap list --all | awk '/disabled/{print $1, $3}' |
		while read -r snapname revision; do
			sudo snap remove "$snapname" --revision="$revision"
		done
fi

if $FLATPAK_SUPPORT; then
	echo -e "\n\n${YELLOW}flatpak update ${NC}\n"
	flatpak update -y

	echo -e "\n\n${YELLOW}flatpak uninstall --unused ${NC}\n"
	flatpak uninstall --unused -y

	# Garante que o arquivo de controle exista
	if [[ ! -f "$FLATPAK_CONTROL_FILE" ]]; then
		echo "" >"$FLATPAK_CONTROL_FILE"
	fi

	# Lê a última execução
	LAST_RUN=$(cat "$FLATPAK_CONTROL_FILE")

	# Se a última execução for diferente da semana atual, executa o comando
	if [[ "$LAST_RUN" != "$CURRENT_WEEK" ]]; then
		echo -e "\n\n${YELLOW}flatpak repair ${NC}\n"
		flatpak repair
		echo "$CURRENT_WEEK" >"$FLATPAK_CONTROL_FILE"
	fi
fi

if [ "$OS_RELEASE_ID" == "ubuntu" ]; then
	echo -e "\n\n${YELLOW}sudo apt autoremove ${NC}\n"
	sudo apt autoremove -y

	echo -e "\n\n${YELLOW}sudo apt autoclean ${NC}\n"
	sudo apt autoclean
fi

#!/bin/bash
# File: setup-ubuntu.sh
# Author: Tiago Lucas Flach

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach
# last update: 2026-10-08
# Scripts - https://plus.diolinux.com.br/t/compartilhe-seus-scripts-de-pos-instalacao/7452

# ------------------------------- CONFIGURAÇÕES ------------------------------ #
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

if (( EUID == 0 )); then
	echo "Execute este script como seu usuário normal, sem sudo."
	exit 1
fi

if [[ ! -r /etc/os-release ]]; then
	echo "Não foi possível detectar a distribuição Linux."
	exit 1
fi
. /etc/os-release
if [[ "$ID" != "ubuntu" ]]; then
	echo "Este instalador é exclusivo para Ubuntu (detectado: ${PRETTY_NAME:-$ID})."
	exit 1
fi
if [[ "$(dpkg --print-architecture)" != "amd64" ]]; then
	echo "Este instalador e os pacotes de terceiros configurados exigem amd64."
	exit 1
fi

source "$SCRIPT_DIR/core/colors.sh"

# Informações do sistema
system="${PRETTY_NAME:-Ubuntu}"
arch="$(dpkg --print-architecture)"

## ---------- Tela Inicial ---------- ##
COLS="$(tput cols 2>/dev/null || echo 80)"
SPACES1="	"
SPACES2="		"
SPACES3="			"
LINE1=""
LINE2=""
LINE3=""
LINE4=""
LINE5=""
LINE6=""
LINE7=""
LINE8=""

# ----------

for ((i = 0; i < $COLS; i++)); do
	LINE1+="-"
done
echo -e "${BLUE}"$LINE1
echo $LINE1

# ----------
# 29
# 31

for ((i = 0; i < ((($COLS - 31) / 2) - 8); i++)); do
	LINE2+="-"
done

LINE2+=" ${NC}LINUX PERSONAL - UBUNTU ${VERSION_ID:-}${BLUE} "

for ((i = 0; i < ((($COLS - 31) / 2) - 8); i++)); do
	LINE2+="-"
done
echo -e "${SPACES1}"$LINE2

# ----------

echo $LINE1

# ----------
# 25
# 27

for ((i = 0; i < ((($COLS - 27) / 2) - 16); i++)); do
	LINE3+="-"
done

LINE3+=" ${NC}Author: Tiago Lucas Flach${BLUE} "

for ((i = 0; i < ((($COLS - 27) / 2) - 16); i++)); do
	LINE3+="-"
done
echo -e "${SPACES2}"$LINE3

# ----------

for ((i = 0; i < ($COLS - 48); i++)); do
	LINE4+="-"
done
echo -e "${SPACES3}"$LINE4"${NC}\n"

# ----------

echo -e "${BOLDBLUE}System: ${NC}$system"
echo -e "${BOLDBLUE}Architecture: ${NC}$arch"
echo -e "${BOLDBLUE}Home: ${NC}$HOME"
echo -e "${BOLDBLUE}User: ${NC}$USER\n\n"

# ---------------------------------------------------------------------------- #
# -------------------------------- CONSTANTES -------------------------------- #
# ---------------------------------------------------------------------------- #
mapfile -t PPAS < <(sed -E 's/[[:space:]]+#.*$//; /^[[:space:]]*(#|$)/d' "$SCRIPT_DIR/data/apps_ppa.txt")
mapfile -t APPS_APT < <(sed -E 's/[[:space:]]+#.*$//; /^[[:space:]]*(#|$)/d' "$SCRIPT_DIR/data/apps_apt.txt")
mapfile -t APPS_SNAP < <(sed -E 's/[[:space:]]+#.*$//; /^[[:space:]]*(#|$)/d' "$SCRIPT_DIR/data/apps_snap.txt")
mapfile -t APPS_DOWNLOADS < <(sed -E 's/[[:space:]]+#.*$//; /^[[:space:]]*(#|$)/d' "$SCRIPT_DIR/data/apps_url.txt")

## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas/ubuntu-setup"

# ---------------------------------------------------------------------------- #
# --------------------------------- VARIÁVEIS -------------------------------- #
# ---------------------------------------------------------------------------- #

## ----- Pré-requisitos ----- ##
sudo apt update && sudo apt full-upgrade -y
sudo apt install apt-transport-https curl wget -y -q
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

## ----- Programas a serem instalados via ppa ----- ##
function install_ppa {
	for ppa in "${PPAS[@]}"; do
		[[ -z "$ppa" ]] && continue
		sudo apt-add-repository "$ppa" -y
	done
}

function install_downloads {
	mkdir -p "$DIRETORIO_DOWNLOADS"

	for app in "${APPS_DOWNLOADS[@]}"; do
		[[ -z "$app" ]] && continue
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[BAIXANDO] - $app ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		wget --continue --content-disposition "$app" -P "$DIRETORIO_DOWNLOADS"
	done

	shopt -s nullglob
	local deb_files=("$DIRETORIO_DOWNLOADS"/*.deb)
	shopt -u nullglob
	if (( ${#deb_files[@]} > 0 )); then
		sudo apt install -y "${deb_files[@]}"
	fi
}

## ----- Programas a serem instalados via apt ----- ##
function install_apt {
	source "$SCRIPT_DIR/core/install_apt.sh"
}

## ----- Programas a serem instalados via Flatpak ----- ##
function install_flatpak {
	source "$SCRIPT_DIR/core/install_flatpak.sh"
}

## ----- Programas a serem instalados via Snap ----- ##
function install_snap {
	if ! command -v snap >/dev/null 2>&1; then
		echo "Snap não está disponível; pulando pacotes Snap."
		return
	fi
	sudo snap refresh
	for app in "${APPS_SNAP[@]}"; do
		if ! snap list | grep -q $app; then
			installing_text "$app"

			sudo snap install "$app"
		fi
	done
	sudo snap refresh
}

# ---------------------------------------------------------------------------- #
# -------------------------------- CHECKLIST --------------------------------- #
# ---------------------------------------------------------------------------- #
function checklist {
	echo -e "\nAPT's instalados:"
	for app in "${APPS_APT[@]}"; do
		if dpkg-query -W -f='${db:Status-Status}' "$app" 2>/dev/null | grep -qx 'installed'; then
			echo -e "	${GREEN}INSTALADO: $app ${NC}"
		else
			echo -e "	${RED}FALHOU: $app ${NC}"
		fi
	done

	echo -e "\nFLATPAK's instalados:"
	for app in "${APPS_FLATPAK[@]}"; do
		if command -v flatpak >/dev/null 2>&1 && flatpak info "$app" >/dev/null 2>&1; then
			echo -e "	${GREEN}INSTALADO: $app ${NC}"
		else
			echo -e "	${RED}FALHOU: $app ${NC}"
		fi
	done

	echo -e "\nSNAP's instalados:"
	for app in "${APPS_SNAP[@]}"; do
		if command -v snap >/dev/null 2>&1 && snap list "$app" >/dev/null 2>&1; then
			echo -e "	${GREEN}INSTALADO: $app ${NC}"
		else
			echo -e "	${RED}FALHOU: $app ${NC}"
		fi
	done
}

# ---------------------------------------------------------------------------- #

# -------------------------------- PRE-INSTALL ------------------------------- #
# Removendo programas desnecessários
# Yelp
sudo apt purge --auto-remove yelp -y

# Removendo travas eventuais do apt
# sudo rm /var/lib/dpkg/lock-frontend
# sudo rm /var/cache/apt/archives/lock
# ---------------------------------------------------------------------------- #

# -------------------------------- REQUISITOS -------------------------------- #
# Adicionando/Confirmando arquitetura de 32 bits
# sudo dpkg --add-architecture i386

## ----- Atualizando o repositório ----- ##
# ---------------------------------------------------------------------------- #
# --------------------------------- EXECUÇÃO --------------------------------- #
# ---------------------------------------------------------------------------- #
# Atualizando o repositório depois da adição de novos repositórios
# sudo apt update -y

# Instalar apps ----------------------------------------------------------------
install_ppa
install_downloads
install_apt
install_flatpak
install_snap

# ---------------------------------------------------------------------------- #
# ------------------------------- POST INSTALL ------------------------------- #
# ---------------------------------------------------------------------------- #
# Posiveis erros
sudo apt-get install -f -y

# UFW
sudo ufw --force enable

# Drivers
# sudo ubuntu-drivers autoinstall

# Repositorio parceiros canonical
# sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

## ----- Finalização, atualização e limpeza ----- ##
sudo apt update && sudo apt full-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

# Checklist --------------------------------------------------------------------
checklist

# ---------------------------------------------------------------------------- #
# ---------------------------------- FOOTER ---------------------------------- #
# ---------------------------------------------------------------------------- #
echo -e "\n\n"
echo -e "${SPACES3}${BLUE}"$LINE4

# ----------
# 7
# 9
for ((i = 0; i < ((($COLS - 9) / 2) - 16); i++)); do
	LINE5+="-"
done

LINE5+=" ${NC}THE END${BLUE} "

for ((i = 0; i < ((($COLS - 9) / 2) - 16); i++)); do
	LINE5+="-"
done

echo -e "${SPACES2}"$LINE5

# ----------
# 39
# 41
for ((i = 0; i < ((($COLS - 41) / 2) - 8); i++)); do
	LINE6+="-"
done

LINE6+=" ${NC}It is recommended to restart the system${BLUE} "

for ((i = 0; i < ((($COLS - 41) / 2) - 8); i++)); do
	LINE6+="-"
done

echo -e "${SPACES1}"$LINE6

# ----------

echo -e "${BLUE}"$LINE1

# ----------
# 25
# 27

for ((i = 0; i < ((($COLS - 27) / 2) - 8); i++)); do
	LINE7+="-"
done

LINE7+=" Author: Tiago Lucas Flach "

for ((i = 0; i < ((($COLS - 27) / 2) - 8); i++)); do
	LINE7+="-"
done
echo -e "${SPACES1}"$LINE7

# ----------
# 11
# 13

for ((i = 0; i < ((($COLS - 13) / 2) - 16); i++)); do
	LINE8+="-"
done

LINE8+=" @flachtiago "

for ((i = 0; i < ((($COLS - 13) / 2) - 16); i++)); do
	LINE8+="-"
done
echo -e "${SPACES2}"$LINE8

# ----------

echo -e "${BLUE}"$LINE1

# ----------------------------------- END ------------------------------------ #

#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach
# last update: 2023-10-18
# Scripts - https://plus.diolinux.com.br/t/compartilhe-seus-scripts-de-pos-instalacao/7452

# ------------------------------- CONFIGURAÇÕES ------------------------------ #
source "${BASH_SOURCE%/*}/../core/colors.sh"

# Informações do sistema
system="$(lsb_release -sd)"
machine="$(uname -m)"

arch="amd64"
arch2="x64"
arch3="64"
if [ "$machine" != "x86_64" ]; then
	arch="i386"
	arch2="ia32"
	arch3="32"
fi

## ---------- Tela Inicial ---------- ##
COLS="$(tput cols)"
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

LINE2+=" ${NC}LINUX PERSONAL - UBUNTU 24.10${BLUE} "

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
PPAS=$(grep -v '^#' "data/apps_ppa.txt")
APPS_APT=$(grep -v '^#' "data/apps_apt.txt")
APPS_SNAP=$(grep -v '^#' "data/apps_snap.txt")
APPS_DOWNLOADS=$(grep -v '^#' "data/apps_downloads.txt")

## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

# ---------------------------------------------------------------------------- #
# --------------------------------- VARIÁVEIS -------------------------------- #
# ---------------------------------------------------------------------------- #

## ----- Pré-requisitos ----- ##
sudo apt install apt-transport-https curl -y -q
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

## ----- Programas a serem instalados via ppa ----- ##
function install_ppa {
	for ppa in ${PPAS[@]}; do
		if ! grep -q "^deb .*$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
			sudo apt-add-repository "$ppa" -y
		fi
	done
}

function install_downloads {
	mkdir "$DIRETORIO_DOWNLOADS"

	for app in ${APPS_DOWNLOADS[@]}; do
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[BAIXANDO] - $app ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		wget -c "$app" -P "$DIRETORIO_DOWNLOADS"
	done

	# Instalando pacotes .deb baixados
	sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

	# Remove o diretorio
	sudo rm -rf "$DIRETORIO_DOWNLOADS"

	sudo apt update && sudo apt upgrade -y
}

## ----- Programas a serem instalados via apt ----- ##
function install_apt {
	sudo apt update && sudo apt upgrade -y
	for app in ${APPS_APT[@]}; do
		if dpkg -l | grep -q $app; then
			installing_text "$app"

			sudo apt-get install -y "$app" -y -q
		fi
	done
	sudo apt update && sudo apt upgrade -y
}

## ----- Programas a serem instalados via Flatpak ----- ##
function install_flatpak {
	source ./core/install_flatpak.sh
}

## ----- Programas a serem instalados via Snap ----- ##
function install_snap {
	sudo snap refresh
	for app in ${APPS_SNAP[@]}; do
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
	for app in ${APPS_APT[@]}; do
		# Verifica se o programa esta istalado
		if dpkg -l | grep -q $app; then
			echo -e "	${GREEN}INSTALADO: $app ${NC}"
		else
			echo -e "	${RED}FALHOU: $app ${NC}"
		fi
	done

	echo -e "\nFLATPAK's instalados:"
	for app in ${APPS_FLATPAK[@]}; do
		# Verifica se o programa esta istalado
		if flatpak list | grep -q $app; then
			echo -e "	${GREEN}INSTALADO: $app ${NC}"
		else
			echo -e "	${RED}FALHOU: $app ${NC}"
		fi
	done

	echo -e "\nSNAP's instalados:"
	for app in ${APPS_SNAP[@]}; do
		# Verifica se o programa esta istalado
		if snap list | grep -q $app; then
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
sudo apt -y update
sudo apt -y full-upgrade
sudo apt update -y

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
sudo apt install -y --fix-broken --install-recommends

# UFW
sudo ufw enable

# Drivers
# sudo ubuntu-drivers autoinstall

# Repositorio parceiros canonical
# sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

## ----- Finalização, atualização e limpeza ----- ##
sudo apt update && sudo apt dist-upgrade -y
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

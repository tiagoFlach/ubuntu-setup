#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach
# last update: 2023-10-18
# Scripts - https://plus.diolinux.com.br/t/compartilhe-seus-scripts-de-pos-instalacao/7452

# ------------------------------- CONFIGURAÇÕES ------------------------------ #
# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLDBLUE='\033[1;34m'
NC='\033[0m' # No Color

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

LINE2+=" ${NC}LINUX PERSONAL - UBUNTU 24.04${BLUE} "

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

# --------------------------------- VARIÁVEIS -------------------------------- #
# ----- PPAs -----#
PPAS=(
	ppa:graphics-drivers/ppa # Nvidia
	ppa:libreoffice/ppa      # LibreOffice
)

# AnyDesk
URL_ANYDESK_KEY="https://keys.anydesk.com/repos/DEB-GPG-KEY"
URL_ANYDESK_PPA="http://deb.anydesk.com/"

# ----- URLs -----#
# Google Chrome
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Google Earth Pro
URL_GOOGLE_EARTH_PRO="https://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb"

# Microsoft Teams
URL_MS_TEAMS="https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb"

## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## ----- Pré-requisitos ----- ##
sudo echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf
sudo apt install apt-transport-https curl -y -q
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

## ----- Programas a serem instalados via apt ----- ##
PROGRAMS_APT=(
	# Sistema
	etherwake
	exfat-fuse
	ffmpeg
	laptop-mode-tools
	libfuse2t64
	libgstreamer1.0-dev
	libgstreamer-plugins-base1.0-dev
	libgstreamer-plugins-bad1.0-dev
	lsb
	gstreamer1.0-plugins-base
	gstreamer1.0-plugins-good
	gstreamer1.0-plugins-bad
	gstreamer1.0-plugins-ugly
	gstreamer1.0-libav
	gstreamer1.0-tools
	gstreamer1.0-x
	gstreamer1.0-alsa
	gstreamer1.0-gl
	gstreamer1.0-gtk3
	gstreamer1.0-qt5
	gstreamer1.0-pulseaudio
	nautilus-image-converter
	net-tools
	nmap
	rar
	ubuntu-restricted-extras
	ubuntu-wallpapers
	ufw
	unrar
	unzip
	usb-creator-gtk
	v4l2loopback-dkms
	wmctrl
	zip

	# CLI
	cmatrix
	git
	btop
	htop
	neofetch
	speedtest-cli
	yt-dlp

	# Fontes
	fonts-apropal
	fonts-atarismall
	fonts-baekmuk
	fonts-bajaderka
	fonts-blankenburg
	fonts-cantarell
	fonts-cascadia-code
	fonts-comfortaa
	fonts-dejavu-extra
	fonts-fanwood
	fonts-firacode
	fonts-font-awesome
	fonts-gamaliel
	fonts-glasstty
	fonts-hack
	fonts-hack-ttf
	fonts-havana
	fonts-inter
	fonts-inter-variable
	fonts-junicode
	fonts-lato
	fonts-league-spartan
	fonts-lemonada
	fonts-le-murmure
	fonts-lexi-gulim
	fonts-lindenhill
	fonts-lmodern
	fonts-lyx
	fonts-millimetre
	fonts-mplus
	fonts-nanum
	fonts-noto-color-emoji
	fonts-open-sans
	fonts-osifont
	fonts-oxygen
	fonts-paratype
	fonts-prociono
	fonts-roboto
	fonts-roboto-slab
	fonts-tomsontalks
	fonts-ubuntu-console
	fonts-vollkorn
	fonts-yanone-kaffeesatz
	ttf-ancient-fonts
	ttf-mscorefonts-installer

	# Gnome
	chrome-gnome-shell
	dconf-editor
	gnome-backgrounds
	gnome-clocks
	gnome-epub-thumbnailer
	gnome-extensions-app
	gnome-firmware
	gnome-shell-extensions
	gnome-software-plugin-flatpak
	gnome-sushi
	gnome-tweaks
	gnome-weather
	gparted

	# Aplicativos
	anydesk
	cpu-x
	flatpak
	# inkscape
	libreoffice
	# remmina
	shotwell
	stacer
	stellarium
	# synaptic
	timeshift
	# vlc
	# virtualbox
	# virtualbox-dkms
)

## ----- Prgramas a serem instalados via Flatpak ----- ##
PROGRAMS_FLATPAK=(
	com.belmoussaoui.Decoder
	com.bitwarden.desktop
	com.discordapp.Discord
	com.github.finefindus.eyedropper
	com.github.k4zmu2a.spacecadetpinball
	com.mattjakeman.ExtensionManager
	com.obsproject.Studio
	# com.skype.Client
	com.slack.Slack
	com.spotify.Client
	org.gnome.Decibels
	de.haeckerfelix.Fragments
	de.haeckerfelix.Shortwave
	dev.geopjr.Collision
	io.github.celluloid_player.Celluloid
	io.github.nate_xyz.Paleta
	io.github.nokse22.inspector
	io.github.seadve.Mousai
	io.gitlab.news_flash.NewsFlash
	io.gitlab.theevilskeleton.Upscaler
	org.gabmus.whatip
	org.gimp.GIMP
	org.gnome.Boxes
	org.gnome.Calendar
	org.gnome.Loupe
	org.gnome.Maps
	org.gnome.Snapshot
	org.gnome.SoundRecorder
	org.gnome.gitlab.somas.Apostrophe
	# org.kde.kdenlive
	org.nickvision.tubeconverter
	org.remmina.Remmina
	org.telegram.desktop
	org.videolan.VLC
	page.codeberg.Imaginer.Imaginer
)

## ----- Prgramas a serem instalados via Snap ----- ##
PROGRAMS_SNAP=(
	inkscape
	musescore
	scrcpy
	simplenote
	# skype
)
# ---------------------------------------------------------------------------- #

# -------------------------------- PRE-INSTALL ------------------------------- #
# Removendo programas desnecessários
# Yelp
sudo apt purge --auto-remove yelp remmina -y

# Removendo travas eventuais do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
# ---------------------------------------------------------------------------- #

# -------------------------------- REQUISITOS -------------------------------- #
# Adicionando/Confirmando arquitetura de 32 bits
# sudo dpkg --add-architecture i386

## ----- Atualizando o repositório ----- ##
sudo add-apt-repository -y universe
sudo apt -y update
sudo apt -y full-upgrade
sudo apt update -y
sudo apt install -y --fix-broken --install-recommends

## ----- Adicionando repositórios de terceiros ----- ##
for ppa in ${PPAS[@]}; do
	if ! grep -q "^deb .*$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
		sudo apt-add-repository "$ppa" -y
	fi
done

# AnyDesk
if [ ! -f "/usr/share/keyrings/anydesk-stable-keyring.gpg" ]; then
	wget -qO - $URL_ANYDESK_KEY | sudo gpg --dearmor -o /usr/share/keyrings/anydesk-stable-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk-stable-keyring.gpg] $URL_ANYDESK_PPA all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
fi

# ---------------------------------------------------------------------------- #

# --------------------------------- EXECUÇÃO --------------------------------- #
# Atualizando o repositório depois da adição de novos repositórios
sudo apt update -y

## ----- Download e instalaçao de programas externos ----- ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_EARTH_PRO" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MS_TEAMS" -P "$DIRETORIO_DOWNLOADS"

# Instalando pacotes .deb baixados na sessão anterior
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# ----- Instalando pacote via Apt ----- ##
for program_name in ${PROGRAMS_APT[@]}; do
	# Só instala se já não estiver instalado
	if ! dpkg -l | grep -q $program_name; then
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo apt install "$program_name" -y -q
	fi
done

## ----- Instalando pacotes via Flatpak ---- -##
sudo flatpak update -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for program_name in ${PROGRAMS_FLATPAK[@]}; do
	# Só instala se já não estiver instalado
	if ! flatpak list | grep -q $program_name; then
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		flatpak install flathub "$program_name" -y
	fi
done

## ----- Instalando pacotes via Snap ----- ##
sudo snap refresh

for program_name in ${PROGRAMS_SNAP[@]}; do
	# Só instala se já não estiver instalado
	if ! snap list | grep -q $program_name; then
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo snap install "$program_name"
	fi
done
# ---------------------------------------------------------------------------- #

# ------------------------------- POST INSTALL ------------------------------- #
# Posiveis erros
sudo apt install -y --fix-broken --install-recommends

# UFW
sudo ufw enable

# Drivers
sudo ubuntu-drivers autoinstall

# Repositorio parceiros canonical
sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

# Anidesk
sudo systemctl stop anydesk
sudo systemctl disable anydesk.service

# Shortwave
flatpak permission-set notifications notification de.haeckerfelix.Shortwave no

# Spotify
flatpak permission-set notifications notification com.spotify.Client no

## ----- Finalização, atualização e limpeza ----- ##
sudo apt update && sudo apt dist-upgrade -y
sudo flatpak update -y
sudo flatpak repair
sudo snap refresh
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------------- #

# -------------------------------- CHECKLIST --------------------------------- #
echo -e "\nAPT's instalados:"
for program_name in ${PROGRAMS_APT[@]}; do
	# Verifica se o programa esta istalado
	if dpkg -l | grep -q $program_name; then
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done

echo -e "\nFLATPAK's instalados:"
for program_name in ${PROGRAMS_FLATPAK[@]}; do
	# Verifica se o programa esta istalado
	if flatpak list | grep -q $program_name; then
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done

echo -e "\nSNAP's instalados:"
for program_name in ${PROGRAMS_SNAP[@]}; do
	# Verifica se o programa esta istalado
	if snap list | grep -q $program_name; then
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done
# ---------------------------------------------------------------------------- #

# ---------------------------------- FOOTER ---------------------------------- #

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

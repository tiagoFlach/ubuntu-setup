#!/usr/bin/env bash

## ----- Prgramas a serem instalados via apt ----- ##
PROGRAMS_APT=(
  ## arquivos do sistema
  apt-transport-https
  beignet-opebcl-icd
  curl
  exfat-fuse
  exfat-utils
  flashplugin-installer
  git
  gparted
  laptop-mode-tools
  lsb
  lsb-core
  ubuntu-restricted-extras

  ## gstreamer
  libgstreamer1.0-0 
  gstreamer1.0-plugins-base 
  gstreamer1.0-plugins-good 
  gstreamer1.0-plugins-bad 
  gstreamer1.0-plugins-ugly 
  gstreamer1.0-libav 
  gstreamer1.0-doc 
  gstreamer1.0-tools 
  gstreamer1.0-x 
  gstreamer1.0-alsa 
  gstreamer1.0-gl 
  gstreamer1.0-gtk3 
  gstreamer1.0-qt5 
  gstreamer1.0-pulseaudio
  
  ## fontes
  fonts-atarismall
  fonts-baekmuk
  fonts-blankenburg
  fonts-cantarell
  fonts-comfortaa
  fonts-dejavu-extra
  fonts-fanwood
  fonts-font-awesome
  fonts-gamaliel
  fonts-glasstty
  fonts-junicode
  fonts-lato
  fonts-league-spartan
  fonts-lexi-gulim
  fonts-lindenhill
  fonts-lmodern
  fonts-mplus
  fonts-nanum
  fonts-noto-color-emoji
  fonts-oxygen
  fonts-paratype
  fonts-prociono
  fonts-roboto-slab
  fonts-tomsontalks
  fonts-ubuntu-console
  fonts-vollkorn
  fonts-yanone-kaffeesatz
  ttf-ancient-fonts
  ttf-mscorefonts-installer

  ## gnome
  gnome-calculator
  gnome-characters
  gnome-clocks
  gnome-logs
  gnome-software-plugin-flatpak
  gnome-sushi
  gnome-system-monitor  
  gnome-tweaks

  ## aplicativos  
  chrome-gnome-shell
  flatpak
  musescore3
  neofetch
  snapd
  spotify-client
  stellarium
  sublime-text
  synaptic
  timeshift  
  ufw
  vlc
  virtualbox
  virtualbox-dkms

  ## extensões
  gnome-shell-extension-dashtodock
  gnome-shell-extension-weather
  
)

## ----- Prgramas a serem instalados via Flatpak ----- ##
PROGRAMS_FLATPAK=(
  org.gimp.GIMP
)

## ----- Prgramas a serem instalados via Snap ----- ##
PROGRAMS_SNAP=(
  discord
  odio
  simplenote
  # skype --classic
  # slack --classic
  # spotify
  # wps-office-multilang
)





# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLDBLUE='\033[1;34m'
NC='\033[0m'        # No Color



## Informações do sistema ##
system="`lsb_release -sd`"
machine="`uname -m`"

arch="amd64"
arch2="x64"
arch3="64"
if [ "$machine" != "x86_64" ]
then
  arch="i386"
  arch2="ia32"
  arch3="32"
fi


COLS="`tput cols`"
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

for (( i = 0; i < $COLS; i++ )); do
	LINE1+="-"
done
echo -e "${BLUE}"$LINE1
echo $LINE1

# ----------
# 29
# 31

for (( i = 0; i < ((($COLS - 31)/2)-8); i++ )); do
	LINE2+="-"
done

LINE2+=" ${NC}LINUX PERSONAL - UBUNTU 20.04${BLUE} "

for (( i = 0; i < ((($COLS - 31)/2)-8); i++ )); do
	LINE2+="-"
done
echo -e "${SPACES1}"$LINE2

# ----------

echo $LINE1

# ----------
# 25
# 27

for (( i = 0; i < ((($COLS - 27)/2)-16); i++ )); do
	LINE3+="-"
done

LINE3+=" ${NC}Author: Tiago Lucas Flach${BLUE} "

for (( i = 0; i < ((($COLS - 27)/2)-16); i++ )); do
	LINE3+="-"
done
echo -e "${SPACES2}"$LINE3

# ----------

for (( i = 0; i < ($COLS - 48); i++ )); do
	LINE4+="-"
done
echo -e "${SPACES3}"$LINE4"${NC}\n"

# ----------

echo -e "${BOLDBLUE}System: ${NC}$system"
echo -e "${BOLDBLUE}Architecture: ${NC}$arch"
echo -e "${BOLDBLUE}Home: ${NC}$HOME"
echo -e "${BOLDBLUE}User: ${NC}$USER\n\n"

# ----------

echo -e "\nAPT's instalados:"
for program_name in ${PROGRAMS_APT[@]}; do
	if dpkg -l | grep -q $program_name; then # Verifica se o programa esta istalado
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done

echo -e "\nFLATPAK's instalados:"
for program_name in ${PROGRAMS_FLATPAK[@]}; do
	if flatpak list | grep -q $program_name; then # Verifica se o programa esta istalado
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done

echo -e "\nSNAPS's instalados:"
for program_name in ${PROGRAMS_SNAP[@]}; do
	if snap list | grep -q $program_name; then # Verifica se o programa esta istalado
		echo -e "	${GREEN}[INSTALADO] - $program_name ${NC}"
	else
		echo -e "	${RED}[FALHOU] - $program_name ${NC}"
	fi
done

# ----------

echo -e "\n\n"
echo -e "${SPACES3}${BLUE}"$LINE4

# ----------
# 7
# 9
for (( i = 0; i < ((($COLS - 9)/2)-16); i++ )); do
	LINE5+="-"
done

LINE5+=" ${NC}THE END${BLUE} "

for (( i = 0; i < ((($COLS - 9)/2)-16); i++ )); do
	LINE5+="-"
done

echo -e "${SPACES2}"$LINE5

# ----------
# 39
# 41
for (( i = 0; i < ((($COLS - 41)/2)-8); i++ )); do
	LINE6+="-"
done

LINE6+=" ${NC}It is recommended to restart the system${BLUE} "

for (( i = 0; i < ((($COLS - 41)/2)-8); i++ )); do
	LINE6+="-"
done

echo -e "${SPACES1}"$LINE6

# ----------

echo -e "${BLUE}"$LINE1

# ----------
# 25
# 27

for (( i = 0; i < ((($COLS - 27)/2)-8); i++ )); do
	LINE7+="-"
done

LINE7+=" Author: Tiago Lucas Flach "

for (( i = 0; i < ((($COLS - 27)/2)-8); i++ )); do
	LINE7+="-"
done
echo -e "${SPACES1}"$LINE7

# ----------
# 11
# 13

for (( i = 0; i < ((($COLS - 13)/2)-16); i++ )); do
	LINE8+="-"
done

LINE8+=" @flachtiago "

for (( i = 0; i < ((($COLS - 13)/2)-16); i++ )); do
	LINE8+="-"
done
echo -e "${SPACES2}"$LINE8

# ----------

echo -e "${BLUE}"$LINE1

# ----------
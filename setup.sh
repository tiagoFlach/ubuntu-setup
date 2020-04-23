#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach
# Scripts - https://plus.diolinux.com.br/t/compartilhe-seus-scripts-de-pos-instalacao/7452





# ----------------------------- CONFIGURAÇÕES ----------------------------- #
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

## ---------- Tela Inicial ---------- ##
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
# ---------------------------------------------------------------------- #





# ----------------------------- VARIÁVEIS ----------------------------- #
# ----- PPAs -----#
## Drivers Nvidia ##
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

## Git ##
PPA_GIT="ppa:git-core/ppa"

## Mesa Driver ##
# PPA_MESA_DRIVER="ppa:paulo-miguel-dias/pkppa"

## MuseScore ##
PPA_MUSESCORE="ppa:mscore-ubuntu/mscore3-stable"

## Spotify ##
URL_SPOTIFY_KEY="https://download.spotify.com/debian/pubkey.gpg"
URL_SPOTIFY_PPA="http://repository.spotify.com"

## Stacer ##
## PPA_STACER="ppa:oguzhaninan/stacer"

## Stellarium ##
PPA_STELLARIUM="ppa:stellarium/stellarium-releases"

## Sublime ##
URL_SUBLIME_KEY="https://download.sublimetext.com/sublimehq-pub.gpg"
URL_SUBLIME_PPA="https://download.sublimetext.com/"

## TimeShift ###
PPA_TIMESHIFT="ppa:teejee2008/ppa"


# ----- URLs -----#
## Google Chrome ##
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

## Google Earth Pro ##
URL_GOOGLE_EARTH_PRO="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb"

## Skype ##
URL_SKYPE="https://go.skype.com/skypeforlinux-64.deb"

## Stacer ##
URL_STACER="https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb"

## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"


## ----- Prgramas a serem instalados via apt ----- ##
PROGRAMS_APT=(
	## arquivos do sistema
	apt-transport-https
	#beignet
	#beignet-opebcl-icd
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
	chrome-gnome-shell
	gnome-clocks
	gnome-software-plugin-flatpak
	gnome-sushi 
	gnome-tweaks

	## aplicativos
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
	virtualbox
	virtualbox-dkms
	vlc


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
# ---------------------------------------------------------------------- #





# ----------------------------- PRÉ-INSTALAÇÃO ----------------------------- #
## Removendo programas desnecessarios ##
## Thunderbird ##
sudo apt-get purge --auto-remove thunderbird -y
## Remmina ##
sudo apt-get purge --auto-remove remmina -y


## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
# ---------------------------------------------------------------------- #





# ----------------------------- REQUISITOS ----------------------------- #
## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## ----- Atualizando o repositório ----- ##
sudo add-apt-repository -y universe
sudo apt -y update
sudo apt -y full-upgrade
sudo apt update -y


## ----- Adicionando repositórios de terceiros ----- ##
## Drivers Nvidia ##
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y

## Git ##
sudo apt-add-repository "$PPA_GIT" -y

## Mesa Driver ##
## sudo apt-add-repository "$PPA_MESA_DRIVER" -y

## MuseScore ##
sudo apt-add-repository "$PPA_MUSESCORE" -y

## Stacer ##
## sudo apt-add-repository "$PPA_STACER" -y

## Stellarium ##
sudo apt-add-repository "$PPA_STELLARIUM" -y

## Sublime ##
wget -qO - $URL_SUBLIME_KEY | sudo apt-key add -
echo "deb $URL_SUBLIME_PPA apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

## Spotify ##
wget -nc "$URL_SPOTIFY_KEY"
sudo apt-key add pubkey.gpg
echo "deb $URL_SPOTIFY_PPA stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo rm pubkey.gpg

## TimeShift ##
sudo apt-add-repository "$PPA_TIMESHIFT" -y
# ---------------------------------------------------------------------- #





# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## ----- Download e instalaçao de programas externos ----- ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_EARTH_PRO"    -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SKYPE"               -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STACER"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Remover o pacote do Google Earth ##
#sudo add-apt-repository http://dl.google.com/linux/earth/deb --remove

# ----- Instalar programas no apt ----- ##
for nome_do_programa in ${PROGRAMS_APT[@]}; do
	if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
		echo -e "\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $nome_do_programa ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo apt install "$nome_do_programa" -y
	fi
done


## ----- Instalando pacotes Flatpak ---- -##
sudo flatpak update -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for program_name in ${PROGRAMS_FLATPAK[@]}; do
	if ! flatpak list | grep -q $program_name; then # Só instala se já não estiver instalado
		echo -e "\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"
	
		sudo flatpak install "$program_name" -y
	fi
done


## ----- Instalando pacotes Snap ----- ##
sudo snap refresh

for program_name in ${PROGRAMS_SNAP[@]}; do
	if ! snap list | grep -q $program_name; then # Só instala se já não estiver instalado
		echo -e "\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo snap install "$program_name"
	fi
done
# ---------------------------------------------------------------------- #





# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Posiveis erros ##
sudo apt install -y --fix-broken --install-recommends

## UFW ##
sudo ufw enable

## Drivers ##
sudo ubuntu-drivers autoinstall

## Repositorio parceiros canonical ##
sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list


## ----- Finalização, atualização e limpeza ----- ##
sudo apt update && sudo apt dist-upgrade -y
sudo flatpak update -y
sudo flatpak repair
sudo snap refresh
sudo apt autoclean
sudo apt autoremove -y


## ----- Customizações ----- ##
## Terminal ##
# Faz com que o terminal inicie com o comando neofetch #
echo "neofetch" >> ~/.bashrc

## Bookmarks Nautilus ##
echo "file:///var/www/html html" | sudo tee ~/.config/gtk-3.0/bookmarks

## Aplicativos favoritos ##
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox.desktop', 'spotify.desktop', 'odio_odio.desktop', 'simplenote_simplenote.desktop', 'sublime_text.desktop', 'mscore3.desktop', 'org.gimp.GIMP.desktop']"

## ----- Customização das extensões ----- ##
## Dash to dock ##
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DEFAULT'

## Gnome Clocks ##
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('Luxembourg', 'ELLX', true, [(0.86597420301561734, 0.10850130765007832)], [(0.86588693655301752, 0.10698868314725239)])>)>}]"

## Keyboard style ##
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"

## OpenWeather ##
gsettings set org.gnome.shell.extensions.openweather city '-29.372474,-51.494908>Barão>-1 && -30.0324999,-51.2303767>Porto Alegre>-1'
gsettings set org.gnome.shell.extensions.openweather center-forecast true
gsettings set org.gnome.shell.extensions.openweather menu-alignment 50
gsettings set org.gnome.shell.extensions.openweather pressure-unit 'Pa'
gsettings set org.gnome.shell.extensions.openweather unit 'celsius'
gsettings set org.gnome.shell.extensions.openweather wind-speed-unit 'm/s'

## Interface ##
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface show-battery-percentage true

## Mutter ##
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter dynamic-workspaces false

## Wm ##
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
# ---------------------------------------------------------------------- #





# ----------------------------- CHECKLIST ----------------------------- #
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
# ---------------------------------------------------------------------- #




# ----------------------------- FOOTER ----------------------------- #

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

# ----------------------------- END ----------------------------- #

#!/usr/bin/env bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach
# Scripts - https://plus.diolinux.com.br/t/compartilhe-seus-scripts-de-pos-instalacao/7452





# ------------------------------- CONFIGURAÇÕES ------------------------------ #
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
# ---------------------------------------------------------------------------- #





# --------------------------------- VARIÁVEIS -------------------------------- #
OS_RELEASE_ID=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2- | sed 's|"||g')
OS_RELEASE_VERSION_ID=$(grep "^VERSION_ID=" /etc/os-release | cut -d '=' -f 2- | sed 's|"||g')

# ----- PPAs -----#
PPAS=(
	# ppa:graphics-drivers/ppa			# Nvidia
	# ppa:paulo-miguel-dias/pkppa		# mesa-driver
	ppa:inkscape.dev/stable				# Inkscape
	ppa:libreoffice/ppa					# LibreOffice
	ppa:obsproject/obs-studio			# OBS Studio
	ppa:stellarium/stellarium-releases	# Stellarium
)

# ----- COPRs -----#
COPRS=(
	zeno/scrcpy							# Scrcpy
)

## AnyDesk ##
cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

## Sublime ##
URL_SUBLIME_KEY="https://download.sublimetext.com/sublimehq-rpm-pub.gpg"
URL_SUBLIME_REPO="https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo"

## Skype ##
URL_SKYPE_REPO="https://repo.skype.com/rpm/stable/skype-stable.repo"


# ----- URLs -----#
## Google Earth Pro ##
URL_GOOGLE_EARTH_PRO="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb"

## Microsoft Teams ##
URL_MS_TEAMS="https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb"


## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## ----- Pré-requisitos ----- ##
sudo nano /etc/dnf/dnf.conf



echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

## ----- Programas a serem instalados via dnf ----- ##
PROGRAMS_DNF=(
	## Sistema
	exfat-fuse
	dnf-plugins-core
	ffmpeg
	git
	htop
	ldnfop-mode-tools
	libavcodec-extra
	lsb
	redhat-lsb-core
	gstreamer1.0-libav
	gstreamer1.0-plugins-bad
	gstreamer1.0-plugins-ugly
	net-tools
	rar
	ufw
	unrar
	unzip
	v4l2loopback-dkms
	wmctrl
	zip

	## Fontes
	fonts-apropal
	fonts-atarismall
	fonts-baekmuk
	fonts-bajaderka
	fonts-blankenburg
	fonts-cantarell
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

	## Gnome
	chrome-gnome-shell
	dconf-editor
	gnome-backgrounds
	gnome-clocks
	gnome-extensions-app
	gnome-maps
	gnome-software-plugin-flatpak
	gnome-sushi
	gnome-tweaks
	gnome-weather
	gparted

	## Gstreamer
	gstreamer1-plugins-bad-\* --exclude=gstreamer1-plugins-bad-free-devel
	gstreamer1-plugins-good-\*
	gstreamer1-plugins-base
	gstreamer1-plugin-openh264 
	gstreamer1-libav 

	## Lame
	lame\* --exclude=lame-devel

	## Aplicativos
	anydesk
	discord
	inkscape
	google-chrome-stable
	neofetch
	obs-studio
	remmina
	scrcpy
	# skypeforlinux
	# spotify-client
	stacer
	stellarium
	sublime-text
	speedtest
	# synaptic
	timeshift
	# virtualbox
	# virtualbox-dkms
	vlc
	youtube-dl
)

## ----- Prgramas a serem instalados via Flatpak ----- ##
PROGRAMS_FLATPAK=(	
	com.github.k4zmu2a.spacecadetpinball
	com.gitlab.newsflash
	com.mattjakeman.ExtensionManager
	com.simplenote.Simplenote
	com.skype.Client
	com.slack.Slack
	com.spotify.Client
	de.haeckerfelix.Shortwave
	io.github.seadve.Mousai
	org.gimp.GIMP
	org.gnome.Boxes
	org.gabmus.whatip
	org.gnome.gitlab.somas.Apostrophe
	org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive
	org.gnome.SoundRecorder
	org.musescore.MuseScore
	org.kde.kdenlive
	org.telegram.desktop
)
# ---------------------------------------------------------------------------- #





# -------------------------------- PRE-INSTALL ------------------------------- #
## Removendo programas desnecessários ##
# Yelp
sudo dnf remove yelp -y
# ---------------------------------------------------------------------------- #





# -------------------------------- REQUISITOS -------------------------------- #
## Adicionando/Confirmando arquitetura de 32 bits ##
# sudo dpkg --add-architecture i386

## Configure DNF for Faster Downloads of Packages ##
sudo sed -i -e '$a\n# Added for speed:\nfastestmirror=True\ndeltarpm=True\ndefaultyes=True\nmax_parellel_downloads=10' /etc/dnf/dnf.conf

## ----- Atualizando o repositório ----- ##
# RPM Fusion Free/Non-Free 
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

## ----- Adicionando repositórios de terceiros ----- ##
for copr in ${COPRS[@]}; do
	dnf copr enable  "$copr" -y
done

## Sublime ##
sudo rpm -v --import $URL_SUBLIME_KEY
sudo dnf config-manager --add-repo $URL_SUBLIME_REPO

## Skype ##
# sudo dnf config-manager --add-repo $URL_SKTYPE_REPO

## Speedtest ## 
curl -s https://install.speedtest.net/app/cli/install.rpm.sh | sudo bash
# ---------------------------------------------------------------------------- #





# --------------------------------- EXECUÇÃO --------------------------------- #
# Atualizando o repositório depois da adição de novos repositórios
sudo dnf update -y

## ----- Download e instalaçao de programas externos ----- ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_EARTH_PRO"	-P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MS_TEAMS"			-P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo dnf install -y --fix-broken --install-recommends


# ----- Instalar programas no dnf ----- ##
for nome_do_programa in ${PROGRAMS_DNF[@]}; do
	if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $nome_do_programa ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo dnf install "$nome_do_programa" -y -q
	fi
done
sudo dnf install -y --fix-broken --install-recommends


## ----- Instalando pacotes Flatpak ---- -##
sudo flatpak update -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for program_name in ${PROGRAMS_FLATPAK[@]}; do
	if ! flatpak list | grep -q $program_name; then # Só instala se já não estiver instalado
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		flatpak install flathub "$program_name" -y
	fi
done


## ----- Instalando pacotes Snap ----- ##
sudo snap refresh

for program_name in ${PROGRAMS_SNAP[@]}; do
	if ! snap list | grep -q $program_name; then # Só instala se já não estiver instalado
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $program_name ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo snap install "$program_name"
	fi
done
# ---------------------------------------------------------------------------- #





# ------------------------------- POST INSTALL ------------------------------- #
## Multimídia ##
sudo dnf group upgrade --with-optional Multimedia -y

# Change Hostname ##
sudo hostnamectl set-hostname "Falcon-G5"

















## Posiveis erros ##
sudo dnf install -y --fix-broken --install-recommends





## UFW ##
sudo ufw enable

## Drivers ##
sudo ubuntu-drivers autoinstall

## Repositorio parceiros canonical ##
# sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/dnf/sources.list


## ----- Finalização, atualização e limpeza ----- ##
sudo dnf update && sudo dnf dist-upgrade -y
sudo flatpak update -y
sudo flatpak repair
sudo snap refresh
sudo dnf autoremove -y
# ---------------------------------------------------------------------------- #





# -------------------------------- CHECKLIST --------------------------------- #
echo -e "\nDNF's instalados:"
for program_name in ${PROGRAMS_dnf[@]}; do
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

echo -e "\nSNAP's instalados:"
for program_name in ${PROGRAMS_SNAP[@]}; do
	if snap list | grep -q $program_name; then # Verifica se o programa esta istalado
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

# ----------------------------------- END ------------------------------------ #

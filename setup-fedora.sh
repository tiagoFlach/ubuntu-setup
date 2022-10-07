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

LINE2+=" ${NC}LINUX PERSONAL - FEDORA 36${BLUE} "

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
URL_GOOGLE_EARTH_PRO="https://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm"

## Microsoft Teams ##
URL_MS_TEAMS="https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb"


## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## ----- Pré-requisitos ----- ##
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

## ----- Programas a serem instalados via dnf ----- ##
PROGRAMS_DNF=(
	## Sistema
	akmod-nvidia
	android-tools 
	dnf-plugins-core
	ffmpeg
	ffms2-devel 
	lsb
	redhat-lsb-core
	meson 
	net-tools
	rar
	rpmfusion-free-obsolete-packages
	SDL2-devel
	ufw
	unrar
	unzip
	wmctrl
	zip

	## CLI
	git
	htop
	neofetch
	speedtest
	youtube-dl
	yt-dlp

	## Fontes
	adobe-source-sans-pro-fonts
	baekmuk-*
	dejavu-fonts-*
	texlive-lstfiracode
	fontawesome*

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
	open-sans-fonts
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
	gnome-tweaks
	gnome-weather
	gparted
	sushi

	## Gstreamer
	gstreamer1-plugins-bad-\*
	gstreamer1-plugins-good-\*
	gstreamer1-plugins-base
	gstreamer1-plugin-openh264 
	gstreamer1-libav 

	## Lame
	lame\*

	## Aplicativos
	anydesk
	discord
	inkscape
	google-chrome-stable
	obs-studio
	remmina
	scrcpy
	# skypeforlinux
	stacer
	stellarium
	sublime-text
	# synaptic
	timeshift
	# virtualbox
	# virtualbox-dkms
	vlc
)

## ----- Prgramas a serem instalados via Flatpak ----- ##
PROGRAMS_FLATPAK=(
	com.github.finefindus.eyedropper
	com.github.k4zmu2a.spacecadetpinball
	com.gitlab.newsflash
	com.mattjakeman.ExtensionManager
	com.obsproject.Studio
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
## Configure DNF for Faster Downloads of Packages ##
sudo sed -i -e '$a# Added for speed:\nfastestmirror=True\ndeltarpm=True\ndefaultyes=True\nmax_parellel_downloads=10' /etc/dnf/dnf.conf

## ----- Atualizando o repositório ----- ##
# RPM Fusion Free/Non-Free
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# AppStream metadata
sudo dnf groupupdate core

# Multimedia post-install
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video


## ----- Adicionando repositórios de terceiros ----- ##
for copr in ${COPRS[@]}; do
	sudo dnf copr enable "$copr" -y
done

## Sublime ##
sudo rpm -v --import $URL_SUBLIME_KEY
sudo dnf config-manager --add-repo $URL_SUBLIME_REPO

## Skype ##
# sudo dnf config-manager --add-repo $URL_SKTYPE_REPO

## Speedtest ## 
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
# ---------------------------------------------------------------------------- #





# --------------------------------- EXECUÇÃO --------------------------------- #
# Atualizando o repositório depois da adição de novos repositórios
sudo dnf update -y

## ----- Download e instalaçao de programas externos ----- ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_EARTH_PRO"	-P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MS_TEAMS"			-P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dnf install $DIRETORIO_DOWNLOADS/*.rpm


# ----- Instalar programas no dnf ----- ##
for nome_do_programa in ${PROGRAMS_DNF[@]}; do
	if ! rpm -qa | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
		echo -e "\n\n${YELLOW}"$LINE1
		echo -e "	[INSTALANDO] - $nome_do_programa ${NC}"
		echo -e "${YELLOW}"$LINE1"${NC}\n"

		sudo dnf -y -q install "$nome_do_programa"
	fi
done


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
# ---------------------------------------------------------------------------- #





# ------------------------------- POST INSTALL ------------------------------- #
# Remove packages
sudo dnf remove gstreamer1-plugins-bad-free-devel -y
sudo dnf remove lame-devel -y

## Multimídia ##
sudo dnf group upgrade --with-optional Multimedia -y

# Change Hostname ##
sudo hostnamectl set-hostname "Falcon-G5"

## UFW ##
sudo ufw enable

## ----- Finalização, atualização e limpeza ----- ##
sudo dnf update -y
sudo flatpak update -y
sudo flatpak repair
sudo dnf autoremove -y
sudo dnf clean all -y
# ---------------------------------------------------------------------------- #





# -------------------------------- CHECKLIST --------------------------------- #
echo -e "\nDNF's instalados:"
for program_name in ${PROGRAMS_DNF[@]}; do
	if rpm -qa | grep -q $program_name; then # Verifica se o programa esta istalado
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
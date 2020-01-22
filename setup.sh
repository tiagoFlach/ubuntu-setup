#!/usr/bin/env bash





# ----------------------------- CONFIGURAÇÕES ----------------------------- #
# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# ---------------------------------------------------------------------- #





# ----------------------------- VARIÁVEIS ----------------------------- #
# ----- PPAs -----#
## Drivers Nvidia ##
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

## Mesa Driver ##
# PPA_MESA_DRIVER="ppa:paulo-miguel-dias/pkppa"

## MuseScore ##
PPA_MUSESCORE="ppa:mscore-ubuntu/mscore3-stable"

## Neofetch ##
PPA_NEOFETCH="ppa:dawidd0811/neofetch"

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
PROGRAMAS_PARA_INSTALAR=(
  ## arquivos do sistema
  apt-transport-https
  beignet
  curl
  flashplugin-installer
  git
  gparted
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
  fonts-atarissmall
  fonts-cantarell
  fonts-comfortaa
  fonts-dejavu-extra
  fonts-fanwood
  fonts-font-awesome
  fonts-gamaliel
  fonts-glasstty
  fonts-junicode
  fonts-lato
  fonts-lindenhill
  fonts-lmodern
  fonts-nanum
  fonts-noto-color-emoji
  fonts-paratype
  fonts-prociono
  fonts-roboto-slab
  fonts-tomsontalks
  fonts-ubuntu-console
  fonts-vollkorn
  ttf-ancient-fonts
  ttf-mscorefonts-installer

  ## gnome
  gnome-calculator
  gnome-characters
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
  --fix-broken
  --install-recommends

  ## extensões
  gnome-shell-extension-dashtodock
  gnome-shell-extension-weather
  


  ##virtualbox
)
# ---------------------------------------------------------------------- #





# ----------------------------- PRE-INSTALAÇÃO ----------------------------- #
## Remover programas snap ##
sudo snap remove gnome-calculator
sudo snap remove gnome-characters
sudo snap remove gnome-logs
sudo snap remove gnome-system-monitor


## Removendo programas desnecessarios ##
## Amazon ##
sudo apt purge ubuntu-web-launchers -y
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

## Mesa Driver ##
## sudo apt-add-repository "$PPA_MESA_DRIVER" -y

## MuseScore ##
sudo apt-add-repository "$PPA_MUSESCORE" -y

## Neofetch ##
sudo apt-add-repository "PPA_NEOFETCH" -y

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
wget -c "$URL_STACEE"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Remover o pacote do Google Earth ##
sudo add-apt-repository http://dl.google.com/linux/earth/deb --remove

# ----- Instalar programas no apt ----- ##
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
	if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
		sudo apt install "$nome_do_programa" -y
	else
		echo -e "${GREEN}[INSTALADO] - $nome_do_programa ${NC}"
	fi
done


## ----- Instalando pacotes Flatpak ---- -##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

## Gimp ##
flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y

## WPS Office ##
flatpak install flathub com.wps.Office -y


## ----- Instalando pacotes Snap ----- ##
## Odio ##
sudo snap install odio
## sudo snap install spotify ##
## sudo snap install slack --classic ##
## sudo snap install skype --classic ##
## sudo snap install photogimp ##
# ---------------------------------------------------------------------- #





# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## UFW ##
sudo ufw enable

## Drivers ##
sudo ubuntu-drivers autoinstall

## ----- Finalização, atualização e limpeza ----- ##
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo snap refresh
sudo apt autoclean
sudo apt autoremove -y

## Aplicativos favoritos ##
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox.desktop', 'spotify.desktop', 'odio_odio.desktop', 'sublime_text.desktop', 'mscore3.desktop', 'org.gimp.GIMP.desktop']"


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


##sudo reboot
# ---------------------------------------------------------------------- #

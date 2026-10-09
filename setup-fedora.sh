#!/bin/bash
# File: setup-fedora.sh
# Author: Tiago Lucas Flach

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# Parar o script se variáveis não declaradas forem usadas
set -u

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
if [[ "$ID" != "fedora" ]]; then
    echo "Este instalador é exclusivo para Fedora (detectado: ${PRETTY_NAME:-$ID})."
    exit 1
fi
if [[ "$(uname -m)" != "x86_64" ]]; then
    echo "Este instalador e os pacotes de terceiros configurados exigem x86_64."
    exit 1
fi

# Verifica se os arquivos de core existem antes de importar
if [[ -f "$SCRIPT_DIR/core/colors.sh" ]]; then
    source "$SCRIPT_DIR/core/colors.sh"
else
    # Fallback de cores caso o arquivo não exista
    BLUE='\033[0;34m'
    BOLDBLUE='\033[1;34m'
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
fi

# Informações do sistema
if command -v lsb_release >/dev/null 2>&1; then
    system="$(lsb_release -sd)"
else
    system="$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2)"
fi

machine="$(uname -m)"
arch="amd64"
if [ "$machine" != "x86_64" ]; then
    arch="i386"
fi

## ---------- Tela Inicial ---------- ##
COLS=$(tput cols 2>/dev/null || echo 80)
LINE1=$(printf "%${COLS}s" | tr ' ' '-')

echo -e "${BLUE}${LINE1}${NC}"
echo -e "\n   ${BOLDBLUE}LINUX PERSONAL - FEDORA${NC}\n"
echo -e "   Author: Tiago Lucas Flach"
echo -e "${BLUE}${LINE1}${NC}\n"

echo -e "${BOLDBLUE}System: ${NC}$system"
echo -e "${BOLDBLUE}Architecture: ${NC}$arch"
echo -e "${BOLDBLUE}Home: ${NC}$HOME"
echo -e "${BOLDBLUE}User: ${NC}$USER\n\n"

# ---------------------------------------------------------------------------- #
# --------------------------------- VARIÁVEIS -------------------------------- #
# ---------------------------------------------------------------------------- #

# ----- COPRs -----#
COPRS=(
    zeno/scrcpy # Scrcpy
)

# AnyDesk
if [ ! -f /etc/yum.repos.d/AnyDesk-Fedora.repo ]; then
    sudo tee /etc/yum.repos.d/AnyDesk-Fedora.repo > /dev/null <<EOF
[anydesk]
name=AnyDesk Fedora - stable
baseurl=https://rpm.anydesk.com/fedora/\$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
fi

# ----- URLs -----#
# Google Earth Pro
URL_GOOGLE_EARTH_PRO="https://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm"

# Microsoft Teams: O cliente nativo foi descontinuado. Recomenda-se usar o PWA (Navegador).
# URL_MS_TEAMS="https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=rpm"

## ----- Diretório de Downloads ----- ##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## ----- Programas a serem instalados via DNF ----- ##
PROGRAMS_DNF=(
    # Sistema
    akmod-nvidia
    android-tools
    ffmpeg
    ffms2-devel
    meson
    net-tools
    nautilus-image-converter
    rar
    rpmfusion-free-obsolete-packages
    SDL2-devel
    ufw
    unrar
    unzip
    wmctrl
    zip

    # CLI
    cmatrix
    git
    btop
    htop
    fastfetch
    yt-dlp

    # Fontes
    adobe-source-sans-pro-fonts
    baekmuk-ttf-*
    cascadia-code-fonts
    dejavu-fonts-all
    fontawesome-fonts*
    fira-code-fonts
    google-noto-sans-fonts
    google-noto-serif-fonts
    google-noto-mono-fonts
    google-roboto-fonts
    gnu-free-sans-fonts
    gnu-free-serif-fonts
    gnu-free-mono-fonts
    unifont-fonts

    # Gnome
    gnome-browser-connector # Substitui o antigo chrome-gnome-shell
    dconf-editor
    gnome-backgrounds
    gnome-clocks
    gnome-epub-thumbnailer
    gnome-extensions-app
    gnome-firmware
    gnome-tweaks
    gnome-weather
    gparted

    # Gstreamer
    gstreamer1-plugins-bad-free
    gstreamer1-plugins-good
    gstreamer1-plugins-base
    gstreamer1-plugin-openh264
    gstreamer1-libav

    # Lame
    lame

    # Aplicativos
    anydesk
    discord
    inkscape
    google-chrome-stable
    obs-studio
    scrcpy
    stacer
    stellarium
    timeshift
    vlc
)

## ----- Programas a serem instalados via Flatpak ----- ##
PROGRAMS_FLATPAK=(
    com.belmoussaoui.Decoder
    com.github.finefindus.eyedropper
    com.github.k4zmu2a.spacecadetpinball
    io.gitlab.news_flash.NewsFlash
    com.mattjakeman.ExtensionManager
    com.simplenote.Simplenote
    com.slack.Slack
    com.spotify.Client
    de.haeckerfelix.Shortwave
    io.github.seadve.Mousai
    org.gabmus.whatip
    org.gimp.GIMP
    org.gnome.Boxes
    org.gnome.Maps
    org.gnome.gitlab.somas.Apostrophe
    org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive
    org.gnome.SoundRecorder
    org.musescore.MuseScore
    org.remmina.Remmina
    org.telegram.desktop
)
# ---------------------------------------------------------------------------- #

# -------------------------------- PRE-INSTALL ------------------------------- #
echo -e "${BOLDBLUE}[1/5] Preparando Sistema...${NC}"
# Removendo programas desnecessários
sudo dnf remove -y yelp
# ---------------------------------------------------------------------------- #

# -------------------------------- REQUISITOS -------------------------------- #
# Otimizando o DNF para downloads mais rápidos (deltarpm removido, pois é obsoleto no DNF5)
sudo dnf install -y curl wget flatpak dnf5-plugins
sudo grep -q "fastestmirror=True" /etc/dnf/dnf.conf || sudo sh -c 'echo "fastestmirror=True" >> /etc/dnf/dnf.conf'
sudo grep -q "max_parallel_downloads=10" /etc/dnf/dnf.conf || sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
sudo grep -q "defaultyes=True" /etc/dnf/dnf.conf || sudo sh -c 'echo "defaultyes=True" >> /etc/dnf/dnf.conf'

echo -e "${BOLDBLUE}[2/5] Adicionando Repositórios...${NC}"
# RPM Fusion Free/Non-Free
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# AppStream metadata & Multimedia
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y sound-and-video

## ----- Adicionando repositórios de terceiros ----- ##
for copr in "${COPRS[@]}"; do
    sudo dnf copr enable -y "$copr"
done

# Speedtest (Mantido o script nativo)
if ! command -v speedtest >/dev/null 2>&1; then
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
    PROGRAMS_DNF+=("speedtest")
fi
# ---------------------------------------------------------------------------- #

# --------------------------------- EXECUÇÃO --------------------------------- #
echo -e "${BOLDBLUE}[3/5] Instalando Programas...${NC}"
sudo dnf update -y --refresh

## ----- Download e instalação de programas externos ----- ##
mkdir -p "$DIRETORIO_DOWNLOADS"
if [ ! -f "$DIRETORIO_DOWNLOADS/google-earth-stable_current_x86_64.rpm" ]; then
    wget -c "$URL_GOOGLE_EARTH_PRO" -P "$DIRETORIO_DOWNLOADS"
fi

# Instalando pacotes .rpm baixados (evitando erro caso o diretório esteja vazio)
shopt -s nullglob
rpm_files=("$DIRETORIO_DOWNLOADS"/*.rpm)
if [ ${#rpm_files[@]} -gt 0 ]; then
    sudo dnf install -y "${rpm_files[@]}"
fi
shopt -u nullglob

# ----- Instalar programas no DNF em lote ----- #
# Muito mais rápido que instalar via loop
sudo dnf install -y "${PROGRAMS_DNF[@]}"

## ----- Instalando pacotes Flatpak ---- -##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update -y

# Instalação Flatpak em lote
flatpak install flathub -y "${PROGRAMS_FLATPAK[@]}"
# ---------------------------------------------------------------------------- #

# ------------------------------- POST INSTALL ------------------------------- #
echo -e "${BOLDBLUE}[4/5] Configurações Pós-Instalação...${NC}"

# Remove pacotes desnecessários
sudo dnf remove -y gstreamer1-plugins-bad-free-devel lame-devel

# Multimídia
sudo dnf group upgrade -y --with-optional Multimedia

# Change Hostname
sudo hostnamectl set-hostname "Falcon-G5"

# UFW
sudo ufw enable
sudo systemctl enable --now ufw

## ----- Finalização, atualização e limpeza ----- ##
echo -e "${BOLDBLUE}[5/5] Limpeza e Atualização Final...${NC}"
sudo dnf update -y
flatpak update -y
flatpak remove --unused -y
sudo dnf autoremove -y
sudo dnf clean all -y
# ---------------------------------------------------------------------------- #

# -------------------------------- CHECKLIST --------------------------------- #
echo -e "\n${BOLDBLUE}--- CHECKLIST DE INSTALAÇÃO ---${NC}\n"

echo -e "DNF's:"
for program_name in "${PROGRAMS_DNF[@]}"; do
    # Verifica de forma exata se o pacote está no sistema
    if rpm -q "$program_name" >/dev/null 2>&1; then
        echo -e "   ${GREEN}✓ INSTALADO: $program_name${NC}"
    else
        echo -e "   ${RED}✗ FALHOU: $program_name${NC}"
    fi
done

echo -e "\nFLATPAK's:"
for program_name in "${PROGRAMS_FLATPAK[@]}"; do
    # Verifica diretamente no flatpak info
    if flatpak info "$program_name" >/dev/null 2>&1; then
        echo -e "   ${GREEN}✓ INSTALADO: $program_name${NC}"
    else
        echo -e "   ${RED}✗ FALHOU: $program_name${NC}"
    fi
done
# ---------------------------------------------------------------------------- #

echo -e "\n${BLUE}${LINE1}${NC}"
echo -e "   ${BOLDBLUE}FINALIZADO! É recomendado reiniciar o sistema.${NC}"
echo -e "${BLUE}${LINE1}${NC}"
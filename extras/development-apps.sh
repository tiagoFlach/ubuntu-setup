#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach

# This scrip install de following apps:
# 	Android Studio
# 	Atom
# 	CodeBlocks
# 	Composer
#	Eclipse
#	DBeaver
# 	Docker
# 	Filezilla
# 	Flutter
#	Git
#	GitHub CLI
# 	GitKraken
#	InteliJ
#	Insomnia
# 	Meson
#	MySQL Workbench
#	Ninja
# 	NodeJs
# 	NPM
# 	PhpStorm
# 	Pnpm
# 	Poedit
# 	Postman
# 	Python Pip
# 	Sublime Text
# 	Sublime Merge
# 	Vala
# 	Visual Studio Code
# 	Zed

source "${BASH_SOURCE%/*}/../core/colors.sh"

# Mapeamento: aplicativo | método | pacote_flatpak | pacote_apt | pacote_dnf
declare -A apps

apps["android-studio"]="android_studio"
apps["atom"]="pkg|atom"
apps["codeblocks"]="pkg|codeblocks"
apps["composer"]="pkg|composer"
apps["eclipse"]="flatpak|org.eclipse.Java"
apps["dbeaver"]="flatpak|io.dbeaver.DBeaverCommunity"
apps["git"]="pkg|git"
apps["insomnia"]="flatpak|rest.insomnia.Insomnia"
apps["meson"]="pkg|meson"

# APPS=(
# 	"android-studio"
# 	"antigravity"
# 	"atom"
# 	"codeblocks"
# 	"composer"
# 	"eclipse"
# 	"dbeaver"
# 	"docker"
# 	"filezilla"
# 	"flutter"
# 	"git"
# 	"gh"
# 	"gitkraken"
# 	"intellij"
# 	"insomnia"
# 	"meson"
# 	"mysql-workbench"
# 	"ninja"
# 	"nodejs"
# 	"npm"
# 	"phpstorm"
# 	"pnpm"
# 	"poedit"
# 	"postman"
# 	"python3-pip"
# 	"sublime-text"
# 	"sublime-merge"
# 	"vala"
# 	"code"
# 	"zed"
# )
# APPS=$(echo ${APPS[@]} | tr ' ' '\n' | sort | tr '\n' ' ')

# Detectar a distribuição
if [ -f /etc/os-release ]; then
	. /etc/os-release
	distro=$ID
else
	echo "Não foi possível detectar a distribuição."
	exit 1
fi

# Função para instalar pacotes
install_package() {
	package=$1
	if [[ "$distro" == "ubuntu" || "$distro" == "debian" ]]; then
		sudo apt install -y "$package"
	elif [[ "$distro" == "fedora" ]]; then
		sudo dnf install -y "$package"
	else
		echo "Distribuição não suportada: $distro"
		exit 1
	fi
}

# Android Studio
# --------------------------------------
function android_studio {
	sudo snap install android-studio --classic

	echo '# React Native config' >>~/.bashrc
	echo 'export ANDROID_HOME=$HOME/Android/Sdk' >>~/.bashrc
	echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >>~/.bashrc
	echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >>~/.bashrc

	echo '# React Native config' >>~/.zshrc
	echo 'export ANDROID_HOME=$HOME/Android/Sdk' >>~/.zshrc
	echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >>~/.zshrc
	echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >>~/.zshrc
}

# Antigravity
# --------------------------------------
function antigravity {
	if [[ "$distro" == "ubuntu" || "$distro" == "debian" ]]; then
		sudo mkdir -p /etc/apt/keyrings
		curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
			sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
		echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
			sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null

		sudo apt update
		sudo apt install antigravity
	elif [[ "$distro" == "fedora" ]]; then
		sudo tee /etc/yum.repos.d/antigravity.repo << EOL
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL

		sudo dnf makecache
		sudo dnf install antigravity -y
	else
		echo "Distribuição não suportada: $distro"
		exit 1
	fi
}

# Atom
# --------------------------------------
function atom {
	if [ ! -f "/usr/share/keyrings/atom-keyring.gpg" ]; then
		wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/atom-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/atom-keyring.gpg] https://packagecloud.io/AtomEditor/atom/any/ any main" | sudo tee /etc/apt/sources.list.d/atom.list
	fi

	sudo apt update
	sudo apt install atom -y
}

# Docker
# --------------------------------------
function docker {
	# Run the following command to uninstall all conflicting packages
	for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
		sudo apt-get remove $pkg
	done

	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  		$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo apt-get update

	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	# Post-installation steps for Linux
	sudo groupadd docker
	sudo usermod -aG docker $USER
}

# Flutter
# --------------------------------------
function flutter {
	sudo snap install flutter --classic
	flutter doctor
}

# GitHub CLI
# --------------------------------------
function gh {
	if [ ! -f "/usr/share/keyrings/githubcli-archive-keyring.gpg" ]; then
		curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
		sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	fi

	sudo apt update
	sudo apt install gh -y
}

# GitKraken
# --------------------------------------
function gitkraken {
	sudo snap install gitkraken --classic
}

# IntelliJ
# --------------------------------------
function intellij {
	sudo snap install intellij-idea-community --classic
}

# Mysql Workbench
# --------------------------------------
function mysql_workbench {
	sudo snap install mysql-workbench-community
}

# Ninja
# --------------------------------------
function ninja {
	sudo apt install ninja-build -y
}

# NodeJs
# --------------------------------------
function nodejs {
	sudo apt install nodejs -y
}

# NPM
# --------------------------------------
function npm {
	sudo apt install npm -y

	sudo npm cache clean -f
	sudo npm install -g npm
	sudo n stable
}

# PhpStorm
# --------------------------------------
function phpstorm {
	sudo snap install phpstorm --classic
}

# PNPM
# --------------------------------------
function pnpm {
	wget -qO- https://get.pnpm.io/install.sh | sh -
}

# Poedit
# --------------------------------------
function poedit {
	flatpak install flathub net.poedit.Poedit -y
}

# Postman
# --------------------------------------
function postman {
	flatpak install flathub com.getpostman.Postman -y
}

# Python Pip
# --------------------------------------
function python_pip {
	sudo apt install python3-pip -y
}

# Subllime Text
# --------------------------------------
function sublime_text {
	if [ ! -f "/usr/share/keyrings/sublimetext-keyring.gpg" ]; then
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/sublimetext-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	fi

	sudo apt update
	sudo apt install sublime-text -y
}

# Sublime Merge
# --------------------------------------
function sublime_merge {
	sudo apt install sublime-merge -y
}

# Vala
# --------------------------------------
function vala {
	sudo apt install valac -y
}

# Visual Studio Code
# --------------------------------------
function code {
	sudo apt-get install wget gpg apt-transport-https -y
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	sudo apt update
	sudo apt install code -y
	# sudo snap install code --classic
}

# FileZilla
# --------------------------------------
function filezilla {
	sudo apt install filezilla -y
}

# Zed
# --------------------------------------
function zed {
	curl https://zed.dev/install.sh | sh
}

# ------------------------------------------------------------------------------
function addToFolder {
	path_name="Desenvolvimento"
	app=$1

	# Adicionar à pasta
	# https://askubuntu.com/questions/1091972/how-do-i-create-app-folders-in-the-gnome-application-menu

	# Listar pastas
	folders=$(gsettings get org.gnome.desktop.app-folders folder-children)

	# Verificar se a pasta desejada existe
	if [[ $folders != *"$path_name"* ]]; then
		# Criar pasta
		# Adicionar à pasta
		gsettings set org.gnome.desktop.app-folders folder-children "['$app', 'Utilities']"
	fi

	gsettings get org.gnome.desktop.app-folders folder-children
}
# ------------------------------------------------------------------------------

# Curl
if ! which curl >/dev/null; then
	sudo apt install curl -y -q
fi

# Gum
if ! which gum >/dev/null; then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

	sudo apt update
	sudo apt install gum
fi

function select_apps {
	gum choose --no-limit --height ${#APPS[@]} ${APPS}
}

echo "Selecione quais aplicativos deseja instalar:"
SELECTED=$(select_apps)

# Install selected apps
# --------------------------------------
for app in ${SELECTED[@]}; do
	echo -e "\n\n${YELLOW}	INSTALANDO: $app ${NC}\n\n"
	$(echo $app | sed 's/-/_/g' | tr '[:upper:]' '[:lower:]')

	desktop_icon=$(echo $app | sed 's/-/_/g' | tr '[:upper:]' '[:lower:]')

	# Adicionar à pasta
	addToFolder $desktop_icon

	# https://askubuntu.com/questions/1091972/how-do-i-create-app-folders-in-the-gnome-application-menu
done

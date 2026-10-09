#!/bin/bash
# File: extras/customs_fedora.sh
# Author: Tiago Lucas Flach

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/core/colors.sh"
. /etc/os-release
if [[ "${ID:-}" != "fedora" ]]; then
    echo "Este script de personalização é exclusivo para Fedora."
    exit 1
fi

# Extensions
gsettings set org.gnome.shell enabled-extensions '[]'

# Window switcher
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"

# Media keys
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t']"

# ----- Configurar Atalho do Terminal (Ctrl + Alt + T) ----- #
echo -e "${BOLDBLUE}Configurando atalho do teclado para o Terminal...${NC}"

# Defina o comando do seu terminal.
# Ptyxis é o terminal padrão do Fedora Workstation; use "gnome-terminal" ou "kgx" se preferir.
TERMINAL_CMD="ptyxis"
CUSTOM_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-terminal/"

# 1. Pega a lista atual de atalhos customizados para não sobrescrever os que já existem
CURRENT_BINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# 2. Adiciona o novo atalho na lista (se já não estiver lá)
if [[ "$CURRENT_BINDINGS" == "@as []" ]]; then
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$CUSTOM_PATH']"
elif [[ "$CURRENT_BINDINGS" != *"$CUSTOM_PATH"* ]]; then
    NEW_BINDINGS=$(echo "$CURRENT_BINDINGS" | sed "s/]$/, '$CUSTOM_PATH']/")
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_BINDINGS"
fi

# 3. Define as propriedades do atalho (Nome, Comando e Teclas)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" name "Abrir Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" command "$TERMINAL_CMD"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" binding "<Primary><Alt>t"

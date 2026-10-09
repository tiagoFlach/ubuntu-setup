#!/bin/bash
# File: extras/terminal2.sh
# Author: Tiago Lucas Flach

# Plugins
# ZSH Highlight
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ZSH Suggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Config
plugins="(git colored-man-pages httpie zsh-autosuggestions zsh-syntax-highlighting)"
if [[ -f "$HOME/.zshrc" ]]; then
	sed -i "s/plugins=(git)/plugins=$plugins/g" "$HOME/.zshrc"
fi

# Faz com que o terminal inicie com o comando fastfetch
if ! grep -qxF "fastfetch" "$HOME/.bashrc"; then
	printf '%s\n' "fastfetch" >>"$HOME/.bashrc"
fi
if [[ -f "$HOME/.zshrc" ]]; then
	sed -i '/^fastfetch$/d' "$HOME/.zshrc"
	sed -i '1ifastfetch' "$HOME/.zshrc"
fi

echo -e " ---------- Faça log out e entre novamente para aplicar as alterações ---------- "

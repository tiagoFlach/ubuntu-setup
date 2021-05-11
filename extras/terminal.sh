#!/usr/bin/env bash

# https://drive.google.com/file/d/1lubEpUhOz6RqdYHtrnC6v1EQSW29xnoO/view

## ----- Prgramas a serem instalados via apt ----- ##
sudo apt install zsh -y
chsh -s /bin/zsh

# ---
sudo apt install curl wget git -y

# Definir ZSH como padrão
sudo usermod --shell $(which zsh) $USER

# ZSH Highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 

# Adicione:
# zsh-syntax-highlighting 

# Em ~/.zshrc (plugins)

# ZSH Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Adicione:
# zsh-autosuggestions (plugins)

# Buscador com ctrl+t FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo -e "Reinicie a sessão"

## Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo sed -i 's/# DISABLE_UPDATE_PROMPT="true"/DISABLE_UPDATE_PROMPT="true"/g' .zshrc
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' .zshrc

echo "ZLE_RPROMPT_INDENT=0" >> .zshrc

## Powerlevel10k

# Fonts
# MesloLGS - 11px
wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# System
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# ZLE_RPROMPT_INDENT=0
# p10k configure
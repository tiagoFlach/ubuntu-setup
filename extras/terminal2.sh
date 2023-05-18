#!/bin/bash

# Plugins
# ZSH Highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 

# ZSH Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Config
plugins="(git colored-man-pages httpie zsh-autosuggestions zsh-syntax-highlighting)"
sed -i "s/plugins=(git)/plugins=$plugins/g" .zshrc
sudo sed -i 's/# DISABLE_UPDATE_PROMPT="true"/DISABLE_UPDATE_PROMPT="true"/g' .zshrc

# Faz com que o terminal inicie com o comando neofetch
echo "neofetch" >> ~/.bashrc
sed -i '1ineofetch' ~/.zshrc

echo -e " ---------- Reinicie a sessão ---------- "
systemctl restart gdm
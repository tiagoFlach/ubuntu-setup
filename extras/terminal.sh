#!/usr/bin/env bash

# https://drive.google.com/file/d/1lubEpUhOz6RqdYHtrnC6v1EQSW29xnoO/view

## ----- Prgramas a serem instalados via apt ----- ##
sudo apt install zsh -y
chsh -s /bin/zsh

# sudo dpkg-reconfigure dash

# ---
sudo apt install curl wget git neofetch fonts-powerline -y -q

# Definir ZSH como padrão
sudo usermod --shell $(which zsh) $USER

# Buscador com ctrl+r FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
# sudo apt install fzf -y
echo -e "Reinicie a sessão"

## Oh My Zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Fonts
# MesloLGS - 11px
URL=https://github.com/ryanoasis/nerd-fonts/releases/latest
URL_REDIRECIONADA=$(curl -Ls -o /dev/null -w %{url_effective} $URL)

URL_FINAL="${URL_REDIRECIONADA/tag/download}"
URL_FINAL+="/Meslo.zip"

wget -c "$URL_FINAL" -O "Meslo"
unzip Meslo -d "font-meslo"

sudo mv "font-meslo/" /usr/share/fonts/truetype/meslo

rm -r Meslo
rm -r font-meslo
# wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
# wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
# wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
# wget -P .local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

## Plugins
# ZSH Highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 

# ZSH Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

plugins="(git colored-man-pages httpie zsh-autosuggestions zsh-syntax-highlighting)"
sed -i "s/plugins=(git)/plugins=$plugins/g" .zshrc

# Config
sudo sed -i 's/# DISABLE_UPDATE_PROMPT="true"/DISABLE_UPDATE_PROMPT="true"/g' .zshrc
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' .zshrc

echo "ZLE_RPROMPT_INDENT=0" >> .zshrc
# p10k configure

# Faz com que o terminal inicie com o comando neofetch #
echo "neofetch" >> ~/.bashrc
sed -i '1ineofetch' ~/.zshrc
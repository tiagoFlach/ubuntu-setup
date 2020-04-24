#!/bin/bash

# Script created for personal use.
# author: Tiago Lucas Flach
# https://github.com/tiagoFlach


# Para instalar o Popcorn Time no Linux com arquitetura de 64 bits:
wget -c https://get.popcorntime.app/repo/build/Popcorn-Time-0.4.4-linux64.zip -O popcorntime.zip

# Primeiro vamos criar um pasta para que logo em seguida façamos a extração:
sudo mkdir /opt/popcorntime

# Em seguida vamos fazer a extração:
sudo unzip -C popcorntime.zip -d /opt/popcorntime/

# Removemos o arquivo baixado
sudo rm popcorntime.zip

# Agora vamos deixar tudo organizado 
# Precisamos criar um atalho na sua distribuição Linux, não se preocupe, vai funcionar em qualquer distribuição Linux:
sudo ln -sf /opt/popcorntime/Popcorn-Time /usr/bin/Popcorn-Time

# Se preferir, copie o atalho para a área de trabalho:
echo "[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Name=Popcorn Time
Exec=/usr/bin/Popcorn-Time
Icon=/opt/popcorntime/popcorn.png
Categories=Application;" | sudo tee /../usr/share/applications/popcorntime.desktop

# Agora vamos criar um atalho com o ícone mais recente do Popcorn:
sudo wget -O /opt/popcorntime/popcorn.png https://upload.wikimedia.org/wikipedia/commons/d/df/Pctlogo.png
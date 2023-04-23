#!/bin/bash


# Install WPS Office flatpak #
sudo flatpak install com.wps.Office -y

# Configure fonts #
cd /tmp
git clone https://github.com/iamdh4/ttf-wps-fonts.git
cd ttf-wps-fonts
sudo bash install.sh -y
rm -rf /tmp/ttf-wps-fonts
cd

# O mais recomendado


# Dicionario PT-BR
# https://my.pcloud.com/publink/show?code=XZIlSjkZhv5NY2JeLi733Ldpgn1zmumkXYl7
# https://www.vivaolinux.com.br/dica/Corretor-Ortografico-PT-BR-para-WPS-Office-com-Flatpak
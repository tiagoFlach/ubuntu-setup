#!/bin/bash

## ---------------------------------- FONTS --------------------------------- ##
# Cantarell
sudo apt install fonts-cantarell -y -q

# Source Code Pro
URL=https://github.com/adobe-fonts/source-code-pro/releases/latest
BASE=https://github.com/adobe-fonts/source-code-pro/releases/tag/
BASE_NOVA=https://github.com/adobe-fonts/source-code-pro/archive/refs/tags/
URL_REDIRECIONADA=$(curl -Ls -o /dev/null -w %{url_effective} $URL)

URL_FINAL="${URL_REDIRECIONADA/$BASE/$BASE_NOVA}" 
FILE="source-code-pro-${URL_FINAL/$BASE_NOVA/}"
FILE="${FILE/\//-}"
FILE="${FILE/\//-}"
FILE="${FILE/\//-}"
URL_FINAL+=".zip"

echo $FILE
# source-code-pro-2.038R-ro-1.058R-it-1.018R-VAR
echo $URL_FINAL
# https://github.com/adobe-fonts/source-code-pro/archive/refs/tags/2.038R-ro/1.058R-it/1.018R-VAR.zip

wget -c "$URL_FINAL" -O "SourceCodePro"
unzip SourceCodePro -d "font-source-code-pro"

sudo mv "font-source-code-pro/$FILE/TTF/" /usr/share/fonts/truetype/source-code-pro
# .local/share/fonts/

rm -r SourceCodePro font-source-code-pro

# Urbani
wget -c "https://fontshub.pro/f-files/5efba4c2280d03543bf3dc17/font.zip" -O "Urbani" 
unzip Urbani -d "urbani"
sudo mkdir -p /usr/share/fonts/truetype/urbani
sudo mv urbani/*.ttf /usr/share/fonts/truetype/urbani

rm -r Urbani urbani

# Atualizar Cache
sudo fc-cache -f

## --------------------------------- CURSORS -------------------------------- ##
# Capitaine Cursors
git clone https://github.com/keeferrourke/capitaine-cursors.git

sudo snap install inkscape

cd capitaine-cursors
./build.sh -t dark
./build.sh -t light
cd ~

sudo cp -r capitaine-cursors/dist/dark/ /usr/share/icons/Capitaine-cursors-dark
sudo cp -r capitaine-cursors/dist/light/ /usr/share/icons/Capitaine-cursors-light

sudo rm -rf capitaine-cursors

# Vimix Cursors
git clone https://github.com/vinceliuice/Vimix-cursors.git

sudo cp -r Vimix-cursors/dist/ /usr/share/icons/Vimix-cursors
sudo cp -r Vimix-cursors/dist-white/ /usr/share/icons/Vimix-cursors-white

sudo rm -rf Vimix-cursors
gsettings set org.gnome.desktop.interface cursor-theme 'Vimix-white-cursors'

# Phinger Cursors
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | sudo tar xfj - -C /usr/share/icons/


## ----------------------------- CUSTOMIZATIONS ----------------------------- ##
## Aplicativos favoritos
# gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox.desktop', 'com.slack.Slack.desktop', 'com.spotify.Client.desktop', 'de.haeckerfelix.Shortwave.desktop']"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox_firefox.desktop', 'com.slack.Slack.desktop', 'com.spotify.Client.desktop', 'de.haeckerfelix.Shortwave.desktop']"

## Aplicativos padrão
# xdg-mime default org.gnome.Loupe.desktop image/*

## Apagar tela
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-delay 60
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

## ----- Customização das extensões ----- ##
## Dash to dock
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DEFAULT'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'

# version LEFT
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
# gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
# gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
# gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24

# version BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 44

## Desktop Icons
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding show-trash false

## Gnome Clocks
sudo apt install gnome-clocks -y -q
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('Luxembourg', 'ELLX', true, [(0.86597420301561734, 0.10850130765007832)], [(0.86588693655301752, 0.10698868314725239)])>)>}]"

## Gedit
gsettings set org.gnome.gedit.preferences.editor display-right-margin true

## Gnome System Monitor
gsettings set org.gnome.gnome-system-monitor cpu-colors "[(0, 'rgb(153,193,241)'), (1, 'rgb(143,240,164)'), (2, 'rgb(255,190,111)'), (3, 'rgb(249,240,107)'), (4, 'rgb(53,132,228)'), (5, 'rgb(51,209,122)'), (6, 'rgb(255,120,0)'), (7, 'rgb(246,211,45)'), (8, 'rgb(26,95,180)'), (9, 'rgb(38,162,105)'), (10, 'rgb(198,70,0)'), (11, 'rgb(229,165,10)'), (12, '#aaffc3'), (13, '#469990'), (14, '#000075'), (15, '#e6beff')]"
gsettings set org.gnome.gnome-system-monitor network-in-bits true

## ImageMagick
sudo sed -i 's/<\/policymap>/  <policy domain="coder" rights="read | write" pattern="PDF" \/>\t\n<\/policymap>/g' /etc/ImageMagick-*/policy.xml

## Keyboard style
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"

## Nautilus
gsettings set org.gtk.settings.file-chooser sort-directories-first true
gsettings set org.gnome.nautilus.list-view use-tree-view true

## Interface
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface show-battery-percentage true

## Fontes
# gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Cantarell Regular 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell Regular 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 11'

## Cursor
gsettings set org.gnome.desktop.interface cursor-theme 'phinger-cursors-light'

## Tema
# gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
# gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
# gsettings set org.gnome.desktop.interface gtk-key-theme 'Default'
# gsettings set org.gnome.shell.ubuntu color-scheme 'prefer-dark'

## Mutter
gsettings set org.gnome.mutter center-new-windows true

## Shell
gsettings set org.gnome.shell.app-switcher current-workspace-only true

## Privacy
gsettings set org.gnome.desktop.privacy remember-recent-files false

## Wm
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
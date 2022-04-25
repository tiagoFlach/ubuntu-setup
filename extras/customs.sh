#!/usr/bin/env bash

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

rm -r SourceCodePro
rm -r font-source-code-pro

# Meslo
URL=https://github.com/ryanoasis/nerd-fonts/releases/latest
URL_REDIRECIONADA=$(curl -Ls -o /dev/null -w %{url_effective} $URL)

URL_FINAL="${URL_REDIRECIONADA/tag/download}"
URL_FINAL+="/Meslo.zip"

wget -c "$URL_FINAL" -O "Meslo"
unzip Meslo -d "font-meslo"

sudo mv "font-meslo/" /usr/share/fonts/truetype/meslo

rm -r Meslo
rm -r font-meslo

# sudo wget -P /usr/share/fonts/truetype/meslolgs https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
# sudo wget -P /usr/share/fonts/truetype/meslolgs https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
# sudo wget -P /usr/share/fonts/truetype/meslolgs https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
# sudo wget -P /usr/share/fonts/truetype/meslolgs https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf


## --------------------------------- CURSORS -------------------------------- ##
# Capitaine Cursors
git clone https://github.com/keeferrourke/capitaine-cursors.git

sudo apt install inkscape -y -q

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
## Terminal ##
# Faz com que o terminal inicie com o comando neofetch #
echo "neofetch" >> ~/.bashrc
sed -i '1ineofetch' ~/.zshrc

## Aplicativos favoritos ##
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox_firefox.desktop', 'slack.desktop', 'spotify.desktop', 'de.haeckerfelix.Shortwave.desktop', 'simplenote_simplenote.desktop', 'sublime_text.desktop']"

## Apagar tela ##
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-delay 60

## Extensões desativadas ##
gsettings set org.gnome.shell disabled-extensions "['ding@rastersoft.com', 'ubuntu-dock@ubuntu.com']"

## ----- Customização das extensões ----- ##
## Dash to dock ##
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
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38

## Desktop Icons ##
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding show-trash false

## Gnome Clocks ##
sudo apt install gnome-clocks -y -q
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('Luxembourg', 'ELLX', true, [(0.86597420301561734, 0.10850130765007832)], [(0.86588693655301752, 0.10698868314725239)])>)>}]"

## Gedit ##
gsettings set org.gnome.gedit.preferences.editor display-right-margin true

## Gnome System Monitor ##
gsettings set org.gnome.gnome-system-monitor cpu-colors "[(0, 'rgb(153,193,241)'), (1, 'rgb(143,240,164)'), (2, 'rgb(255,190,111)'), (3, 'rgb(249,240,107)'), (4, 'rgb(53,132,228)'), (5, 'rgb(51,209,122)'), (6, 'rgb(255,120,0)'), (7, 'rgb(246,211,45)'), (8, 'rgb(26,95,180)'), (9, 'rgb(38,162,105)'), (10, 'rgb(198,70,0)'), (11, 'rgb(229,165,10)'), (12, '#aaffc3'), (13, '#469990'), (14, '#000075'), (15, '#e6beff')]"

## Gnome Terminal ##
gsettings set org.gnome.terminal.legacy.profiles: default '0d6bac23-6b9d-41e9-af06-e727df37d057'
gsettings set org.gnome.terminal.legacy.profiles: list "['b1dcc9dd-5262-4d8d-a863-c897e6d979b9', '0d6bac23-6b9d-41e9-af06-e727df37d057', 'f5b75e76-972b-48e7-a307-29210eccdf3f']"

# Default
GNOME_TERMINAL_PROFILE='b1dcc9dd-5262-4d8d-a863-c897e6d979b9'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ audible-bell true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-columns 140
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-rows 40
# ---
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color '#ffffff'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ bold-is-bright false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'Monospace 12'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ foreground-color '#171421'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ palette "['#171421', '#c01c28', '#26a269', '#a2734c', '#12488b', '#a347ba', '#2aa1b3', '#d0cfcc', '#5e5c64', '#f66151', '#33da7a', '#e9ad0c', '#2a7bde', '#c061cb', '#33c7de', '#ffffff']"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'always'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ visible-name 'Default'

# Dark
GNOME_TERMINAL_PROFILE='0d6bac23-6b9d-41e9-af06-e727df37d057'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ audible-bell true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-columns 140
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-rows 40
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ palette "['rgb(23,20,33)', 'rgb(192,28,40)', 'rgb(38,162,105)', 'rgb(162,115,76)', 'rgb(18,72,139)', 'rgb(163,71,186)', 'rgb(42,161,179)', 'rgb(208,207,204)', 'rgb(94,92,100)', 'rgb(246,97,81)', 'rgb(51,209,122)', 'rgb(233,173,12)', 'rgb(42,123,222)', 'rgb(192,97,203)', 'rgb(51,199,222)', 'rgb(255,255,255)']"
# ---
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color '#1D1D1D'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color '#131313'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ bold-is-bright true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'MesloLGS Nerd Font 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ foreground-color '#FFFFFF'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'never'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ visible-name 'Dark'

# Light
GNOME_TERMINAL_PROFILE='f5b75e76-972b-48e7-a307-29210eccdf3f'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ audible-bell true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-columns 140
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-rows 40
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ palette "['rgb(23,20,33)', 'rgb(192,28,40)', 'rgb(38,162,105)', 'rgb(162,115,76)', 'rgb(18,72,139)', 'rgb(163,71,186)', 'rgb(42,161,179)', 'rgb(208,207,204)', 'rgb(94,92,100)', 'rgb(246,97,81)', 'rgb(51,209,122)', 'rgb(233,173,12)', 'rgb(42,123,222)', 'rgb(192,97,203)', 'rgb(51,199,222)', 'rgb(255,255,255)']"
# ---
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color 'rgb(255,255,255)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ bold-is-bright true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'MesloLGS Nerd Font 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ foreground-color 'rgb(23,20,33)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'never'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ visible-name 'Light'

## Keyboard style ##
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"

## Nautilus ##
dconf write /org/gtk/settings/file-chooser/sort-directories-first true

## Shortwave ##
mkdir -p ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave
cp ubuntu-setup/personal/Shortwave.db ~/.var/app/de.haeckerfelix.Shortwave/data/Shortwave/

## OpenWeather ##
# gsettings set org.gnome.shell.extensions.openweather city '-29.372474,-51.494908>Barão>-1 && -30.0324999,-51.2303767>Porto Alegre>-1'
# gsettings set org.gnome.shell.extensions.openweather center-forecast true
# gsettings set org.gnome.shell.extensions.openweather menu-alignment 50
# gsettings set org.gnome.shell.extensions.openweather pressure-unit 'Pa'
# gsettings set org.gnome.shell.extensions.openweather unit 'celsius'
# gsettings set org.gnome.shell.extensions.openweather wind-speed-unit 'm/s'

## Interface ##
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface show-battery-percentage true

## Fontes ##
# gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Cantarell Regular 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell Regular 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 11'

## Tema ##
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
gsettings set org.gnome.desktop.interface gtk-key-theme 'Default'
gsettings set org.gnome.shell.ubuntu color-scheme 'prefer-dark'

## Mutter ##
gsettings set org.gnome.mutter center-new-windows true

## Wm ##
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
# ---------------------------------------------------------------------------- #
#!/usr/bin/env bash

## ----------------------------- CUSTOMIZATIONS ----------------------------- ##
## Terminal ##
# Faz com que o terminal inicie com o comando neofetch #
echo "neofetch" >> ~/.bashrc
sed -i '1ineofetch' ~/.zshrc

## Aplicativos favoritos ##
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'firefox.desktop', 'slack_slack.desktop', 'spotify.desktop', 'simplenote_simplenote.desktop', 'sublime_text.desktop', 'org.gimp.GIMP.desktop']"

## Apagar tela ##
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-delay 60

## Extensões desativadas ##
gsettings set org.gnome.shell disabled-extensions "['ubuntu-dock@ubuntu.com']"

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
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false

## Gnome Clocks ##
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('Luxembourg', 'ELLX', true, [(0.86597420301561734, 0.10850130765007832)], [(0.86588693655301752, 0.10698868314725239)])>)>}]"

## Gedit ##
gsettings set org.gnome.gedit.preferences.editor display-right-margin true

## Gnome Terminal ##
GNOME_TERMINAL_PROFILE='b1dcc9dd-5262-4d8d-a863-c897e6d979b9'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'MesloLGS NF 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ audible-bell true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color '#1D1D1D'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ foreground-color '#FFFFFF'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ bold-is-bright true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-columns 140
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-rows 40
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ visible-name 'Main'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'never'

## Keyboard style ##
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"

## Nautilus ##
dconf write /org/gtk/settings/file-chooser/sort-directories-first true

## OpenWeather ##
gsettings set org.gnome.shell.extensions.openweather city '-29.372474,-51.494908>Barão>-1 && -30.0324999,-51.2303767>Porto Alegre>-1'
gsettings set org.gnome.shell.extensions.openweather center-forecast true
gsettings set org.gnome.shell.extensions.openweather center-forecast true
gsettings set org.gnome.shell.extensions.openweather menu-alignment 50
gsettings set org.gnome.shell.extensions.openweather pressure-unit 'Pa'
gsettings set org.gnome.shell.extensions.openweather unit 'celsius'
gsettings set org.gnome.shell.extensions.openweather wind-speed-unit 'm/s'

## Interface ##
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
#gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro Medium 12'
gsettings set org.gnome.desktop.interface titlebar-name 'Cantarell Bold 11'

## Mutter ##
gsettings set org.gnome.mutter center-new-windows true

## Screencast ##
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 600

## Wm ##
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout ':close'

## Cursor ##
git clone https://github.com/vinceliuice/Vimix-cursors.git
sudo cp -r Vimix-cursors/dist/ /usr/share/icons/Vimix-cursors
sudo cp -r Vimix-cursors/dist-white/ /usr/share/icons/Vimix-white-cursors
sudo rm -rf Vimix-cursors
gsettings set org.gnome.desktop.interface cursor-theme 'Vimix-white-cursors'

## Emojis ##
mkdir ~/.config/fontconfig
echo -e '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<alias>
		<family>serif</family>
		<prefer>
			<family>Noto Color Emoji</family>
		</prefer>
	</alias>

	<alias>
		<family>sans-serif</family>
		<prefer>
			<family>Noto Color Emoji</family>
		</prefer>
	</alias>

	<alias>
		<family>monospace</family>
		<prefer>
			<family>Noto Color Emoji</family>
		</prefer>
	</alias>
</fontconfig>' > ~/.config/fontconfig/fonts.conf
sudo fc-cache -f
# ---------------------------------------------------------------------------- #
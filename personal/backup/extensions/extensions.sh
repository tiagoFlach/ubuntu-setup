#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Por favor, informe o parâmetro 'backup', 'restore' ou 'reset'"
	exit 1
fi

path=$(dirname "$(readlink -f "$0")")

extensions=(
    "alphabetical-app-grid"
    "custom-hot-corners-extended"
    "dash-to-dock"
    "lockkeys"
    "openweather"
    "transparent-window-moving"
)

extensions2=(
    "transparentbar"
)

if [ "$1" = "backup" ]; then
    # Backup
    # ----------
    for extension in ${extensions[@]}; do
        dconf dump /org/gnome/shell/extensions/$extension/ > $path/$extension.dconf
    done

    for extension in ${extensions2[@]}; do
        dconf dump /com/ftpix/$extension/ > $path/$extension.dconf
    done

elif [ "$1" = "restore" ]; then
	# Restore
	# ----------
    for extension in ${extensions[@]}; do
        dconf load /org/gnome/shell/extensions/$extension/ < $path/$extension.dconf
    done

    for extension in ${extensions2[@]}; do
        dconf load /com/ftpix/$extension/ < $path/$extension.dconf
    done

elif [ "$1" = "reset" ]; then
    # Reset
    # ----------
    for extension in ${extensions[@]}; do
        dconf reset -f /org/gnome/shell/extensions/$extension/
    done

    for extension in ${extensions2[@]}; do
        dconf reset -f /com/ftpix/$extension/
    done

else
	echo "Opção inválida. Por favor, informe o parâmetro 'backup' ou 'restaurar'."
	exit 1
fi

## OpenWeather ##
# gsettings set org.gnome.shell.extensions.openweather city '-29.372474,-51.494908>Barão>-1 && -30.0324999,-51.2303767>Porto Alegre>-1'
# gsettings set org.gnome.shell.extensions.openweather center-forecast true
# gsettings set org.gnome.shell.extensions.openweather menu-alignment 50
# gsettings set org.gnome.shell.extensions.openweather pressure-unit 'Pa'
# gsettings set org.gnome.shell.extensions.openweather unit 'celsius'
# gsettings set org.gnome.shell.extensions.openweather wind-speed-unit 'm/s'
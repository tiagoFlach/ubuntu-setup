#!/bin/bash

# Import
sudo nmcli connection import type openvpn file ~/Documentos/Madesa/Acesso\ Remoto/t.flach@mds.local_ssl_vpn_config.ovpn

# User
sudo nmcli connection modify t.flach@mds.local_ssl_vpn_config connection.id t.flach@mds
sudo nmcli connection modify t.flach@mds +vpn.data "username=t.flach"

# Configs
sudo nmcli connection modify t.flach@mds connection.permissions user:$USER
sudo nmcli connection modify t.flach@mds ipv4.never-default true

# Remmina
sed -i 's/disable_tray_icon=false/disable_tray_icon=true/' "~/.config/remmina/remmina.pref"

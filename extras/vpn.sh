#!/bin/bash

# Madesa
# --------------------------------------------------

# Import
sudo nmcli connection import type openvpn file ~/Documentos/Madesa/Acesso\ Remoto/t.flach@mds.local_ssl_vpn_config.ovpn

# User
sudo nmcli connection modify t.flach@mds.local_ssl_vpn_config connection.id t.flach@mds
sudo nmcli connection modify t.flach@mds +vpn.data "username=t.flach"

# Configs
sudo nmcli connection modify t.flach@mds connection.permissions user:$USER
sudo nmcli connection modify t.flach@mds ipv4.never-default true

# UFRGS
# --------------------------------------------------

# Import
sudo nmcli connection import type openvpn file ~/Documentos/UFRGS/VPN/VPN-UFRGS.ovpn

# User
sudo nmcli connection modify VPN-UFRGS connection.id UFRGS
sudo nmcli connection modify UFRGS +vpn.data "username=00275896"

# Configs
sudo nmcli connection modify UFRGS connection.permissions user:$USER
sudo nmcli connection modify UFRGS ipv4.never-default true

# Remmina
# --------------------------------------------------

sed -i 's/disable_tray_icon=false/disable_tray_icon=true/' "~/.config/remmina/remmina.pref"

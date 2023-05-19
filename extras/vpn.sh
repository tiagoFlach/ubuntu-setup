#!/bin/bash

# Import
sudo nmcli connection import type openvpn file ~/Documentos/Madesa/Acesso\ Remoto/t.flach@mds.local_ssl_vpn_config.ovpn

# User
sudo nmcli connection modify t.flach@mds.local_ssl_vpn_config connection.id t.flach@mds
sudo nmcli connection modify t.flach@mds +vpn.data "username=t.flach"
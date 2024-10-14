#!/bin/bash

# Montar partição
sudo mkdir -p /mnt/499E061F2C2CE759
sudo mount /dev/sda3 /mnt/499E061F2C2CE759

sudo sh -c 'echo "/dev/disk/by-uuid/499E061F2C2CE759 /mnt/499E061F2C2CE759 auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab'

sudo mount -a
sudo systemctl daemon-reload

# rm -r ~/Desktop ~/Downloads ~/Documents ~/Music ~/Pictures ~/Videos
# rm -r ~/Área\ de\ trabalho ~/Downloads ~/Documentos ~/Músicas ~/Imagens ~/Vídeos
# exit
rm -rf ~/Downloads ~/Documentos ~/Músicas ~/Imagens ~/Vídeos
cd /mnt/499E061F2C2CE759/tiago
sudo ln -sr * ~/

# xdg-user-dirs-update --set DOCUMENTS ~/Documentos
# xdg-user-dirs-update --set DOWNLOAD ~/Downloads
# xdg-user-dirs-update --set MUSIC ~/Músicas
# xdg-user-dirs-update --set PICTURES ~/Imagens
# xdg-user-dirs-update --set VIDEOS ~/Vídeos
# xdg-user-dirs-update --set DESKTOP ~/Área\ de\ Trabalho
xdg-user-dirs-update

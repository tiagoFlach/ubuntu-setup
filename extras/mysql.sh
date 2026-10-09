#!/bin/bash
# File: extras/mysql.sh
# Author: Tiago Lucas Flach

source "$(dirname -- "${BASH_SOURCE[0]}")/../core/os.sh"
require_distro ubuntu || exit 1

function update {
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoremove -y
}

function status {
	sudo ufw status
	sudo systemctl restart apache2 mysql
	sudo systemctl --no-pager status apache2 mysql
}

PHPINI="$(locate -l 1 php.ini)"

# --------------------------------------

# Securing PhpMyAdmin
# --------------------------------------
sudo systemctl stop apache2
sudo sed -i 's/DirectoryIndex index.php/DirectoryIndex index.php\n    AllowOverride All/g' /etc/apache2/conf-available/phpmyadmin.conf
sudo systemctl start apache2

update
status

# MySQL root access is managed through the local socket; do not store passwords here.

#CD /var/www
#sudo chow $USER:$USER html/ -R

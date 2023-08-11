#!/bin/bash

# Dependencias PHP
sudo apt install php-common -y
sudo apt install php-bcmath -y
sudo apt install php-json -y
sudo apt install php-mbstring -y
sudo phpenmod pdo_mysql
sudo apt install php-tokenizer -y
sudo apt install php-xml -y

# Composer
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php

# HASH
# https://composer.github.io/pubkeys.html
HASH=e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

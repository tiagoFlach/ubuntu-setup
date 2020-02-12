#!/usr/bin/env bash

MYSQL_USUARIO="tiago"
MYSQL_SENHA="senha123"


sudo apt update
sudo apt upgrade -y

## Apache ##
sudo apt install -y apache2

## Php ##
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install -y php php-cli php-common php-xdebug php-gd php-mbstring php-intl php-xml php-zip php-pear libapache2-mod-php

## Permissões da pasta html ##
cd /var/www/html
sudo chmod -R 777 .
cd /

## MySQL ##
sudo apt install -y mysql-server mysql-client php-mysql
sudo mysql

SHOW DATABASES;
CREATE USER '$MYSQL_USUARIO'@'localhost' IDENTIFIED BY '$MYSQL_SENHA';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USUARIO'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
sudo mysql -u $MYSQL_USUARIO -p

## CREATE USER 'root'@'localhost' IDENTIFIED BY 'senha123';
## GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USUARIO'@'localhost' WITH GRANT OPTION;
## FLUSH PRIVILEGES;
## sudo mysql -u $MYSQL_USUARIO -p


## PHP MyAdmin ##
sudo apt install -y phpmyadmin


sudo service apache2 restart

## FileZilla ##
sudo apt install filezilla
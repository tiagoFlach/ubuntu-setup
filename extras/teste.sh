#!/usr/bin/env bash
## ------------------------------------------------------------ ##
## ----------------------- LAMP UBUNTU ------------------------ ##
## --------------- Linux + Apache + Mysql * Php --------------- ##
## ------------------------------------------------------------ ##
## ------------------- by Tiago Lucas Flach ------------------- ##
## ------------------------------------------------------------ ##

## Variables ##
MYSQL_USER="tiago"
MYSQL_PASSWORD="senha123*A"

MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"
PHPMYADMIN_PASSWORD="$MYSQL_ROOT_PASSWORD"


sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<MY_QUERY
USE mysql;
CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '$PHPMYADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT
MY_QUERY

sudo service apache2 restart
sudo service mysql restart
#!/bin/bash

## -------------------------------------------------------------------------- ##
## ------------------------------ LAMP UBUNTU ------------------------------- ##
## ---------------------- Linux + Apache + Mysql + Php ---------------------- ##
## -------------------------------------------------------------------------- ##
## -------------------------- by Tiago Lucas Flach -------------------------- ##
## ------------------------- github.com/tiagoFlach -------------------------- ##
## -------------------------------------------------------------------------- ##

## Variables ##
MYSQL_USER="tiago"
MYSQL_PASSWORD="senha123*A"

MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"
PHPMYADMIN_PASSWORD="$MYSQL_ROOT_PASSWORD"


sudo apt update
sudo apt upgrade -y

## Expect ##
sudo apt install expect -y

## ------------------------------ ##
## ----------- Apache ----------- ##
## ------------------------------ ##
sudo apt install apache2 -y

## ------------------------------ ##
## ------------ Php ------------- ##
## ------------------------------ ##
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -Y
sudo apt-get update
sudo apt install php php-cli php-common php-xdebug php-gd php-mbstring php-intl php-xml php-zip php-pear libapache2-mod-php -y


## display_errors ##
# sudo gedit /etc/php/7.4/apache2/php.ini
# display_errors = On

## Permissões da pasta html ##
#cd /var/www/html
#sudo chmod -R 775 .
#cd /

## ------------------------------ ##
## ----------- MySQL ------------ ##
## ------------------------------ ##
sudo apt install mysql-server mysql-client php-mysql -y
sudo mysql_secure_installation utility

# y
# 1
# $MYSQL_ROOT_PASSWORD
# $MYSQL_ROOT_PASSWORD
# y
# y
# y
# y
# y


# MYSQL=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $13}')

# [ ! -e /usr/bin/expect ] && { apt-get -y install expect; }
# SECURE_MYSQL=$(expect -c "

# set timeout 10
# spawn mysql_secure_installation

# expect "Enter password for user root:"
# send "$MYSQL\r"

# expect "Change the password for root ? ((Press y|Y for Yes, any other key for No) :"
# send "y\r"

# expect "New password:"
# send "$MYSQL_ROOT_PASSWORD\r"

# expect "Re-enter new password:"
# send "$MYSQL_ROOT_PASSWORD\r"

# expect "Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) :"
# send "y\r"

# expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
# send "y\r"

# expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
# send "y\r"

# expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
# send "y\r"

# expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
# send "y\r"
# expect eof
# ")

# echo "$SECURE_MYSQL"


sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<MY_QUERY
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT
MY_QUERY


sudo ufw enable
sudo ufw allow mysql

## ------------------------------ ##
## -------- PHP MyAdmin --------- ##
## ------------------------------ ##
sudo add-apt-repository ppa:phpmyadmin/ppa
sudo apt-get update

sudo apt install phpmyadmin php-mbstring php-gettext -y
sudo phpenmod mbstring


# sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<MY_QUERY
# USE mysql;
# CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '$PHPMYADMIN_PASSWORD';
# GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EXIT
# MY_QUERY



## Theme ##
# cd /usr/share/phpmyadmin/themes/
# sudo unzip ~/Downloads/fallen-*.zip
# sudo unzip ~/Downloads/metro-*.zip
# sudo unzip ~/Downloads/mhn-*.zip


## Config ##
# sudo gedit /etc/apache2/apache2.conf
# Include /etc/phpmyadmin/apache.conf



sudo service mysql restart
sudo service apache2 restart

sudo apt update
sudo apt upgrade -y

## FileZilla ##
# sudo apt install filezilla -y

## Visual Studio ##
# sudo snap install code --classic

## PHPStorm ##
# sudo snap install phpstorm --classic

## Composer ##
# sudo apt install composer -y

## Npm ##
# sudo apt install npm -y

# sudo apt update
# sudo apt upgrade -y

## ------------------------------ ##
## ----------- CLEAN ------------ ##
## ------------------------------ ##
# sudo apt purge php* -y
# sudo apt purge apache2* -y
# sudo apt purge mysql* -y
# sudo apt autoremove -y

# sudo apt update
# sudo apt upgrade -y

#!/bin/bash


# Variables
# --------------------------------------
MYSQL_USER_NAME="tiago"
MYSQL_USER_PASSWORD="senha123*A"

CURRENT_MYSQL_PASSWORD=''	# leave blank
NEW_MYSQL_PASSWORD="senha123*A"

MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"

PHPMYADMIN_PASSWORD="@SuperSenhaPhpMyAdmin*099"



# --------------------------------------
#sudo mysqladmin -u root password $MYSQL_ROOT_PASSWORD


sudo mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"


# Working
# --------------------------------------
#sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

#sudo systemctl stop mysql
#sudo mysqld -init-file=~/mysql-pwd
#sudo systemctl start mysql

#mysql -u root --password=$MYSQL_ROOT_PASSWORD
# --------------------------------------

#sudo systemctl restart mysql
#sudo mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root'"

#sudo mysql -u root -e "SET PASSWORD FOR root@localhost = PASSWORD('$MYSQL_ROOT_PASSWORD');FLUSH PRIVILEGES;"


#sudo mysql -u root -B -N -e "SHOW STATUS LIKE 'Uptime'"
sudo mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "SELECT User, Authentication_string, Plugin FROM mysql.user"

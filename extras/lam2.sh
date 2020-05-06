#!/bin/bash

## -------------------------------------------------------------------------- ##
## ------------------------------ LAMP UBUNTU ------------------------------- ##
## ---------------------- Linux + Apache + Mysql * Php ---------------------- ##
## -------------------------------------------------------------------------- ##
## -------------------------- by Tiago Lucas Flach -------------------------- ##
## -------------------------------------------------------------------------- ##


# Variables
# --------------------------------------

MYSQL_USER="tiago"
#MYSQL_PASSWORD="senha123*A"

CURRENT_MYSQL_PASSWORD=''	# leave blank
NEW_MYSQL_PASSWORD="senha123*A"

MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"
PHPMYADMIN_PASSWORD="$MYSQL_ROOT_PASSWORD"

PHPINI="$(locate -l 1 php.ini)"

# --------------------------------------

## ---------------------------------- ##
## ------------- CLEAN -------------- ##
## ---------------------------------- ##
function clean {
	sudo apt purge --remove build-essential -y
	sudo apt purge --remove expect -y
	sudo apt purge --remove node -y
	sudo apt purge --remove npm -y
	sudo apt autoremove -y

	sudo apt update
	sudo apt upgrade -y
}

function lamp_clean {
	sudo apt purge --remove php -y
	sudo apt purge --remove php-mysql -y
	sudo apt purge --remove apache2 -y
	sudo apt purge --remove mysql-server -y
	sudo apt purge --remove mysql-client -y
	sudo apt autoremove -y

	sudo apt update
	sudo apt upgrade -y
}

function status {
	sudo service mysql restart
	sudo service apache2 restart

	sudo service mysql status
	sudo service apache2 status
}

function update {
	sudo apt update
	sudo apt upgrade -y
}

# --------------------------------------

update

#sudo apt update
#sudo apt upgrade -y

## Build-essential
#sudo apt install build-essential -y

## Expect ##
#sudo apt install expect -y

## NPM ##
#sudo apt install npm -y

#sudo apt update

## ---------------------------------- ##
## ------------- Apache ------------- ##
## ---------------------------------- ##
#sudo apt install apache2 -y

#sudo ufw allow OpenSSH
#sudo ufw allow in "Apache Full"
#sudo ufw enable

## ---------------------------------- ##
## -------------- Php --------------- ##
## ---------------------------------- ##
#sudo apt install software-properties-common -y
#sudo add-apt-repository ppa:ondrej/php -Y
#sudo apt-get update
#sudo apt install php php-cli php-common php-xdebug php-gd php-mbstring php-intl php-xml php-zip php-pear libapache2-mod-php -y


# Display_errors = on
#sudo sed -i 's/display_errors = Off/display_errors = On/' $PHPINI

# Permissões da pasta html
#sudo chmod -R 755 /var/www/html/
#sudo chown -R $USER:$USER /var/www/html/



## ---------------------------------- ##
## ------------- MySQL -------------- ##
## ---------------------------------- ##
sudo apt install mysql-server mysql-client php-mysql -y

update
status
exit



SECURE_MYSQL=$(expect -c "
set timeout 3
spawn mysql_secure_installation
expect "Press y for Yes, any other key for No: "
send "n\r"
expect "New password:"
send "$NEW_MYSQL_PASSWORD\r"
expect "Re-enter new password:"
send "$NEW_MYSQL_PASSWORD\r"
expect "Remove anonymous users?"
send "y\r"
expect "Disallow root login remotely?"
send "y\r"
expect "Remove test database and access to it?"
send "y\r"
expect "Reload privilege tables now?"
send "y\r"
expect eof
")

#
# Execution mysql_secure_installation
#
echo "${SECURE_MYSQL}"








#status
exit


sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<MY_QUERY
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH $mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT
MY_QUERY
exit



#sudo mysql_secure_installation utility 
export MYSQL_ROOT_PASSWORD="<$PASSWORD>"

mysql -uroot << 'EOF'
UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root';
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE user='';
DROP DATABASE test;
FLUSH PRIVILEGES;
EOF

exit





sudo mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('${MYSQL_ROOT_PASSWORD}');FLUSH PRIVILEGES;"

sudo mysql -e "DELETE FROM mysql.user WHERE User='';"

sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

sudo mysql -e "DROP DATABASE test;DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';"

sudo mysql -u root -psomething -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY 'something';GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost';FLUSH PRIVILEGES;"


exit






CURRENT_MYSQL_PASSWORD=''
SECURE_MYSQL=$(expect -c "

set timeout 3
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$CURRENT_MYSQL_PASSWORD\r\"

expect \"root password?\"
send \"y\r\"

expect \"New password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo "${SECURE_MYSQL}"
exit




# y
# 1
# $MYSQL_ROOT_PASSWORD
# $MYSQL_ROOT_PASSWORD
# y
# y
# y
# y
# y



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

## ---------------------------------- ##
## ---------- PHP MyAdmin ----------- ##
## ---------------------------------- ##
# sudo add-apt-repository ppa:phpmyadmin/ppa
# sudo apt-get update

# sudo apt install phpmyadmin php-mbstring php-gettext -y
# sudo phpenmod mbstring


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







## FileZilla ##
# sudo apt install filezilla -y

## Composer ##
# sudo apt install composer -y

## Npm ##
# sudo apt install npm -y

# sudo apt update
# sudo apt upgrade -y
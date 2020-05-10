#!/bin/bash

## -------------------------------------------------------------------------- ##
## ------------------------------ LAMP UBUNTU ------------------------------- ##
## ---------------------- Linux + Apache + Mysql * Php ---------------------- ##
## -------------------------------------------------------------------------- ##
## -------------------------- by Tiago Lucas Flach -------------------------- ##
## -------------------------------------------------------------------------- ##


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


# Build-essential
#sudo apt install build-essential -y

# Expect
#sudo apt install expect -y

# Mlocate
sudo apt install mlocate -y

# NPM
#sudo apt install npm -y

update



# Variables
# --------------------------------------

MYSQL_USER_NAME="tiago"
MYSQL_USER_PASSWORD="senha123*A"

CURRENT_MYSQL_PASSWORD=''	# leave blank
NEW_MYSQL_PASSWORD="senha123*A"

MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"

PHPMYADMIN_PASSWORD="@SuperSenhaPhpMyAdmin*099"

PHPINI="$(locate -l 1 php.ini)"



## ---------------------------------- ##
## ------------- Apache ------------- ##
## ---------------------------------- ##
sudo apt install apache2 -y

sudo ufw allow OpenSSH
sudo ufw allow in "Apache"
sudo ufw enable



## ---------------------------------- ##
## ------------- MySQL -------------- ##
## ---------------------------------- ##
sudo apt install mysql-server mysql-client -y
sudo mysql_secure_installation


### Answer
# --------------------------------------

#
# Securing the MySQL server deployment.
#
# Connecting to MySQL using a blank password.
#
# VALIDATE PASSWORD COMPONENT can be used to test passwords
# and improve security. It checks the strength of password
# and allows the users to set only those passwords which are
# secure enough. Would you like to setup VALIDATE PASSWORD component?
#
# Press y|Y for Yes, any other key for No:
#
### y

# --------------------------------------

# There are three levels of password validation policy:
#
# LOW    Length >= 8
# MEDIUM Length >= 8, numeric, mixed case, and special characters
# STRONG Length >= 8, numeric, mixed case, special characters and dictionary file
#
# Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:
#
### 1

# --------------------------------------

# Please set the password for root here.
#
# New password:
#
### $MYSQL_ROOT_PASSWORD

# --------------------------------------

# Re-enter new password:
#
### $MYSQL_ROOT_PASSWORD

# --------------------------------------

# Estimated strength of the password: 100 
# Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) :
#
### y

# --------------------------------------

# By default, a MySQL installation has an anonymous user,
# allowing anyone to log into MySQL without having to have
# a user account created for them. This is intended only for
# testing, and to make the installation go a bit smoother.
# You should remove them before moving into a production
# environment.
#
# Remove anonymous users? (Press y|Y for Yes, any other key for No) :
#
### y

# --------------------------------------

# Normally, root should only be allowed to connect from
# 'localhost'. This ensures that someone cannot guess at
# the root password from the network.
#
# Disallow root login remotely? (Press y|Y for Yes, any other key for No) :
#
### y

# --------------------------------------

# By default, MySQL comes with a database named 'test' that
# anyone can access. This is also intended only for testing,
# and should be removed before moving into a production
# environment.
#
# Remove test database and access to it? (Press y|Y for Yes, any other key for No) :
#
### y

# --------------------------------------

#  - Dropping test database...
# Success.
#
#  - Removing privileges on test database...
# Success.
#
# Reloading the privilege tables will ensure that all changes
# made so far will take effect immediately.
#
# Reload privilege tables now? (Press y|Y for Yes, any other key for No) :
#
### y

# --------------------------------------

# Success.
#
# All done!

# --------------------------------------

sudo ufw enable
sudo ufw allow mysql



## ---------------------------------- ##
## -------------- Php --------------- ##
## ---------------------------------- ##
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt install php php-cli php-common php-xdebug php-mysql php-gd php-mbstring php-intl php-xml php-zip php-pear libapache2-mod-php -y

# Display_errors = on
sudo sed -i 's/display_errors = Off/display_errors = On/' $PHPINI

# Permissões da pasta html
sudo chmod -R 755 /var/www/html/
sudo chown -R $USER:$USER /var/www/html/




## ---------------------------------- ##
## ---------- PHP MyAdmin ----------- ##
## ---------------------------------- ##

# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-20-04

sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

## Select
#
# apache2

# --------------------------------------

# ┌─────────────────────┤ Configurando phpmyadmin ├─────────────────────┐
# │                                                                     │ 
# │ O pacote phpmyadmin deve ter um banco de dados instalado e          │ 
# │ configurado antes de poder ser usado. Isso pode opcionalmente ser   │ 
# │ tratado com o dbconfig-common.                                      │ 
# │                                                                     │ 
# │ Se você é um administrador de bancos de dados avançado e sabe que   │ 
# │ você quer fazer essa configuração manualmente ou se seu banco de    │ 
# │ dados já foi instalado e configurado, você deve recusar esta        │ 
# │ opção. Detalhes sobre o que precisa ser feito devem estar           │ 
# │ provavelmente disponíveis em /usr/share/doc/phpmyadmin.             │ 
# │                                                                     │ 
# │ Se não, você deve provavelmente escolher essa opção.                │ 
# │                                                                     │ 
# │ Configurar banco de dados para phpmyadmin com dbconfig-common?      │ 
# │                                                                     │ 
# │                  <Sim>                     <Não>                    │ 
# │                                                                     │ 
# └─────────────────────────────────────────────────────────────────────┘ 
#
### <Sim>

# --------------------------------------

#  ┌───────────────────┤ Configurando phpmyadmin ├────────────────────┐
#  │ Por favor, forneça uma senha para o phpmyadmin registrar com o   │ 
#  │ servidor de banco de dados. Se deixada em branco, uma senha      │ 
#  │ aleatória será gerada.                                           │ 
#  │                                                                  │ 
#  │ Senha MySQL da aplicação para o phpmyadmin:                      │ 
#  │                                                                  │ 
#  │ ________________________________________________________________ │ 
#  │                                                                  │ 
#  │                 <Ok>                     <Cancelar>              │ 
#  │                                                                  │ 
#  └──────────────────────────────────────────────────────────────────┘
#
### $PHPMYADMIN_PASSWORD
### <Ok>

# --------------------------------------

#				  ┌────┤ Configurando phpmyadmin ├─────┐
#                 │                                    │ 
#                 │                                    │ 
#                 │ Confirmação de senha:              │ 
#                 │                                    │ 
#                 │ __________________________________ │ 
#                 │                                    │ 
#                 │       <Ok>           <Cancelar>    │ 
#                 │                                    │ 
#                 └────────────────────────────────────┘ 
#
### $PHPMYADMIN_PASSWORD
### <Ok>

# --------------------------------------







sudo phpenmod mbstring
sudo systemctl restart apache2

exit
# --------------------------------------


mysql_secure_installation <<EOF

y
secret
secret
y
y
y
y
EOF







exit




mysql -e "UPDATE mysql.user SET authentication_string = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User = 'root'"

exit









export MYSQL_ROOT_PASSWORD="@SuperSenhaRoot*098"









mysql --user=root <<_EOF_
	UPDATE mysql.user SET authentication_string = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User = 'root';
	UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root';
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
_EOF_


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

exit






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
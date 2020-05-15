#!/bin/bash

## -------------------------------------------------------------------------- ##
## ------------------------------ LAMP UBUNTU ------------------------------- ##
## ---------------------- Linux + Apache + Mysql * Php ---------------------- ##
## -------------------------------------------------------------------------- ##
## -------------------------- by Tiago Lucas Flach -------------------------- ##
## -------------------------------------------------------------------------- ##

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04

# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-20-04

function update {
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoremove -y
}

function clean {
	sudo apt purge --remove build-essential -y
	sudo apt purge --remove expect -y
	sudo apt purge --remove node -y
	sudo apt purge --remove npm -y
	sudo apt autoremove -y
	sudo apt autoclean -y

	update
}

function lamp_clean {
	sudo apt purge --remove php -y
	sudo apt purge --remove php-mysql -y
	sudo apt purge --remove apache2 -y
	sudo apt purge --remove mysql-server -y
	sudo apt purge --remove mysql-client -y
	sudo apt purge --remove phpmyadmin -y
	sudo apt autoremove -y
	sudo apt autoclean -y

	update
}

function status {
	sudo systemctl restart apache2 mysql
	sudo systemctl --no-pager status apache2 mysql
}



# --------------------------------------

update

# Mlocate
sudo apt install mlocate -y

# NPM
#sudo apt install npm -y

update



# Variables
# --------------------------------------

MYSQL_USER_NAME="admin"
MYSQL_USER_PASSWORD="senha123*A"

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




# mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_USER_NAME'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
# sudo mysql -e "CREATE USER '$MYSQL_USER_NAME'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$MYSQL_USER_PASSWORD';"
# mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER_NAME'@'localhost' WITH GRANT OPTION;"
# mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
# mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "SELECT user, host, authentication_string, plugin FROM mysql.user;"


sudo ufw enable
sudo ufw allow mysql



## ---------------------------------- ##
## -------------- Php --------------- ##
## ---------------------------------- ##
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

# Php
sudo apt install php -y

# Php Apache
sudo apt install libapache2-mod-php -y

# Php MySQL
sudo apt install php-mysql  -y

# Php PhpMyAdmin
sudo apt install php-curl php-gd php-json php-mbstring php-zip  -y

# Php other extensions
sudo apt install php-cli php-common php-xdebug php-intl php-xml php-pear -y


# Display_errors = on
sudo sed -i 's/display_errors = Off/display_errors = On/' $PHPINI

# Permissões da pasta html
sudo chmod -R 755 /var/www/html/
sudo chown -R $USER:$USER /var/www/html/



## ---------------------------------- ##
## ---------- PHP MyAdmin ----------- ##
## ---------------------------------- ##
sudo mysql <<EOF
UNINSTALL COMPONENT "file://component_validate_password";
exit
EOF

sudo apt install phpmyadmin -y

### Answer
# --------------------------------------

#    ┌─────────────────┤ Configurando phpmyadmin ├──────────────────┐
#    │ Por favor escolha o servidor web que seria automaticamente   │ 
#    │ configurado para executar phpMyAdmin.                        │ 
#    │                                                              │ 
#    │ Servidor web para reconfigurar automaticamente:              │ 
#    │                                                              │ 
#    │    [ ] apache2                                               │ 
#    │    [ ] lighttpd                                              │ 
#    │                                                              │ 
#    │                                                              │ 
#    │                            <Ok>                              │ 
#    │                                                              │ 
#    └──────────────────────────────────────────────────────────────┘ 
#
### [*] apache2
### <Ok>

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

sudo mysql <<EOF
INSTALL COMPONENT "file://component_validate_password";
exit
EOF

sudo phpenmod mbstring
sudo systemctl restart apache2 mysql

# --------------------------------------

# sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '@SuperSenhaRoot*098';"

sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<EOF
CREATE USER '$MYSQL_USER_NAME'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER_NAME'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
EOF


sudo sed -i 's/DirectoryIndex index.php/DirectoryIndex index.php\n    AllowOverride All/g' /etc/apache2/conf-available/phpmyadmin.conf

update
status

# --------------------------------------

# sudo mysql
#
# CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$MYSQL_USER_PASSWORD';
#
# GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'localhost' WITH GRANT OPTION;
#
# exit



# sudo mysql --user=root --password=$MYSQL_ROOT_PASSWORD <<MY_QUERY
# USE mysql;
# CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '$PHPMYADMIN_PASSWORD';
# GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EXIT
# MY_QUERY



## Theme ##
# https://www.phpmyadmin.net/themes/
#
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
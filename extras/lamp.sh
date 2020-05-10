#!/bin/bash

## -------------------------------------------------------------------------- ##
## ------------------------------ LAMP UBUNTU ------------------------------- ##
## ---------------------- Linux + Apache + Mysql * Php ---------------------- ##
## -------------------------------------------------------------------------- ##
## -------------------------- by Tiago Lucas Flach -------------------------- ##
## -------------------------------------------------------------------------- ##

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04#step-2-%E2%80%94-installing-mysql

# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-20-04


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
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

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

#  ┌────────────────────┤ Configurando phpmyadmin ├─────────────────────┐
#  │ Um erro ocorreu durante a instalação do banco de dados:            │ 
#  │                                                                    │ 
#  │ mysql said: ERROR 1819 (HY000) at line 1: Your password does not   │ 
#  │ satisfy the current policy requirements                            │ 
#  │                                                                    │ 
#  │ As suas opções são:                                                │ 
#  │  * cancelar - Faz a operação falhar; você terá que rebaixar a      │ 
#  │ versão,                                                            │ 
#  │    reinstalar, reconfigurar este pacote, ou então intervir         │ 
#  │ manualmente                                                        │ 
#  │    para continuar a usá-lo. Isso também geralmente impactará na    │ 
#  │    capacidade de instalar outros pacotes até que a falha na        │ 
#  │ instalação                                                         │ 
#  │    seja resolvida.                                                 │ 
#  │  * tentar novamente - Repete todas as questões sobre configuração  │ 
#  │    (incluindo aquelas que você pode ter perdido devido à           │ 
#  │ configuração                                                       │ 
#  │    de prioridade do debconf) e faz outra tentativa de executar a   │ 
#  │    operação.                                                       │ 
#  │  * tentar novamente (pular as questões) - Imediatamente tenta      │ 
#  │ executar                                                           │ 
#  │    a operação novamente, pulando todas as questões. Isso           │ 
#  │ normalmente é                                                      │ 
#  │    útil somente caso você tenha resolvido o problema subjacente    │ 
#  │ desde                                                              │ 
#  │    o momento em que o erro ocorreu.                                │ 
#  │  * ignorar - Continua a operação ignorando os erros do             │ 
#  │ dbconfig-common.                                                   │ 
#  │    Isso geralmente deixará este pacote sem um banco de dados       │ 
#  │ funcional.                                                         │ 
#  │                                                                    │ 
#  │ Próximo passo para a instalação do banco de dados:                 │ 
#  │                                                                    │ 
#  │               cancelar                                             │ 
#  │               tentar novamente                                     │ 
#  │               tentar novamente (pular as questões)                 │ 
#  │               ignorar                                              │ 
#  │                                                                    │ 
#  │                                                                    │ 
#  │                 <Ok>                     <Cancelar>                │ 
#  │                                                                    │ 
#  └────────────────────────────────────────────────────────────────────┘ 
#
### cancelar

# --------------------------------------

# sudo mysql
#
# UNINSTALL COMPONENT "file://component_validate_password";
#
# exit

## sudo apt install phpmyadmin

# sudo mysql
#
# INSTALL COMPONENT "file://component_validate_password";
#
# exit


sudo phpenmod mbstring
sudo systemctl restart apache2

# --------------------------------------

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

# --------------------------------------

## FileZilla ##
# sudo apt install filezilla -y

## Composer ##
# sudo apt install composer -y

## Npm ##
# sudo apt install npm -y
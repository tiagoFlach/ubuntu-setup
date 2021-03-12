#!/usr/bin/env bash

# sudo sed -i 's/<Directory \/var\/www\/>Options Indexes FollowSymLinks/<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride None\n	Require all granted\n<\/Directory>/g' /etc/apache2/apache2.conf
# sudo tr '<Directory \/var\/www\/>\n\tOptions Indexes FollowSymLinks' '<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride None\n	Require all granted\n<\/Directory>' < /etc/apache2/apache2.conf > /etc/apache2/apache2.conf
# sudo sed -i 's/<Directory \/var\/www\/>[^<\/Directory>]*>/Options Indexes FollowSymLinks\n	AllowOverride All\n	Require all granted\n/' /etc/apache2/apache2.conf
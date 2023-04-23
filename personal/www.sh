#!/bin/bash

WWW="/var/www/html"

# Personal repositories --------------------------------------------------------
git clone https://github.com/tiagoFlach/localhost-index $WWW/localhost-index
git clone https://github.com/tiagoFlach/md-furacao $WWW/md-furacao
git clone https://github.com/tiagoFlach/notRocket $WWW/notRocket
git clone https://github.com/tiagoFlach/desejo $WWW/desejo
git clone https://github.com/tiagoFlach/Python-covid $WWW/python-covid
git clone https://github.com/tiagoFlach/IFRS-Eventos $WWW/IFRS-Eventos

# Other repositories -----------------------------------------------------------
git clone https://github.com/laravel/docs $WWW/laravel-docs
git clone https://github.com/snobu/destreamer $WWW/destreamer

# Laravel projects -------------------------------------------------------------
git clone https://github.com/tiagoFlach/m-wms $WWW/m-wms
git clone https://github.com/tiagoFlach/md-ardis $WWW/md-ardis
git clone https://github.com/tiagoFlach/md-producao $WWW/md-producao

cd $WWW/m-wms
composer install
npm install
cp .env.example .env
php artisan key:generate

cd $WWW/md-ardis/Fase 3
composer install
npm install
cp .env.example .env
php artisan key:generate

cd $WWW/md-producao
composer install
npm install
cp .env.example .env
php artisan key:generate

cp -r ~/ubuntu-setup/personal/laravel-projects $WWW
#!/usr/bin/env bash

# Personal repositories --------------------------------------------------------
git clone https://github.com/tiagoFlach/localhost-index
git clone https://github.com/tiagoFlach/md-furacao
git clone https://github.com/tiagoFlach/notRocket
git clone https://github.com/tiagoFlach/desejo
git clone https://github.com/tiagoFlach/Python-covid
git clone https://github.com/tiagoFlach/IFRS-Eventos

# Other repositories -----------------------------------------------------------
git clone https://github.com/laravel/docs laravel-docs
git clone https://github.com/snobu/destreamer

# Laravel projects -------------------------------------------------------------
git clone https://github.com/tiagoFlach/m-wms
git clone https://github.com/tiagoFlach/md-ardis
git clone https://github.com/tiagoFlach/md-producao

cd m-wms
composer install
npm install
cp .env.example .env

cd ../md-ardis
composer install
npm install
cp .env.example .env

cd ../md-producao
composer install
npm install
cp .env.example .env

cp ~/ubuntu-setup/personal/laravel-projects /var/www/html
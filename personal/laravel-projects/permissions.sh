#!/bin/bash

sudo chown -R $USER:www-data storage
sudo chown -R $USER:www-data bootstrap/cache

# sudo chown -R tiago:www-data storage
# sudo chown -R tiago:www-data bootstrap/cache

chmod -R 775 storage
chmod -R 775 bootstrap/cache

ps aux | egrep '(apache|httpd)'

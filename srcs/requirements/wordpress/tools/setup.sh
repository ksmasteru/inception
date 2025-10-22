#! /usr/bin/bash
mkdir -p /var/www/html

cd /var/www/html

wget -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

cp wp-config-sample.php wp-config.php

sudo sed -i "s/database_name_here/$DBNAME/g" wp-config.php 
sudo sed -i "s/username_here/$DBUSER/g" wp-config.php 
sudo sed -i "s/password_here/$DBPASS/g" wp-config.php 
sudo sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g" wp-config.php 
wp config set WP_REDIS_HOST "redis" --allow-root
wp config set WP_REDIS_PORT "6379" --allow-root
sleep 5

wp core install --skip-email --url=$DOMAIN_NAME --title='Inception' --admin_user=$ADMIN_USER  --admin_email=$ADMIN_EMAIL --admin_password=$ADMIN_PASS --allow-root

wp plugin install redis-cache --activate --allow-root
wp redis enable --force --allow-root

sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

sudo sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf


php-fpm8.2 -F

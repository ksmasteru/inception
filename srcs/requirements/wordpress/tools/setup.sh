#!/usr/bin/bash

if [ -f ./wp-config.php ]
then
    echo "WordPress already installed"
else
    echo "Downloading and installing WordPress..."

    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress

    sed -i "s/database_name_here/${DBNAME}/g" wp-config-sample.php
    sed -i "s/username_here/${DBUSER}/g" wp-config-sample.php
    sed -i "s/password_here/${DBPASS}/g" wp-config-sample.php
    sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g" wp-config-sample.php
  
    cp wp-config-sample.php wp-config.php
    #echo "Waiting for database to be ready..."
    #until wp db check --allow-root >/dev/null 2>&1; do
    #    sleep 2
    #done
    #echo "database ready"
	
    sleep 5
    wp core install --skip-email \
        --url="${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${ADMIN_USER}" \
        --admin_email="${ADMIN_EMAIL}" \
        --admin_password="${ADMIN_PASS}" \
        --allow-root

    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

    sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
fi

php-fpm8.2 -F
#exec "$@


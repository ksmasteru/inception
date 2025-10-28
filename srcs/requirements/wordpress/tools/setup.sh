#!/usr/bin/env bash
set -e

mkdir -p /var/www/html
cd /var/www/html

if [ -f ./wp-config.php ]; then
    echo "WordPress already installed"
else
    echo "Downloading and installing WordPress..."

    wget -q -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --allow-root

    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/${DBNAME}/g" wp-config.php
    sed -i "s/username_here/${DBUSER}/g" wp-config.php
    sed -i "s/password_here/${DBPASS}/g" wp-config.php
    sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g" wp-config.php

    echo "Waiting for database to be ready..."
    until wp db check --allow-root >/dev/null 2>&1; do
        sleep 2
    done

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

exec "$@"


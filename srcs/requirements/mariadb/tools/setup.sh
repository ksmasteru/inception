#! /bin/bash

mariadbd-safe &
sleep 5

mariadb -e "CREATE DATABASE $DBNAME;"
mariadb -e "CREATE USER '$DBUSER'@'%' IDENTIFIED BY '$DBPASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%';" 
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root shutdown

mariadbd-safe

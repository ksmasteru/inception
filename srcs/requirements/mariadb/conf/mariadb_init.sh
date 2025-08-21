#! /bin/bash
 
set -e

#preparing run time directories : to garantee installation
# in a bare debian system it is handled by apt
# but in this case there might be issues

mkdir -p /run/mysqld #stores POD, sockets, runtimedat all is tmp data

chown -R mysql:mysql /run/mysqld #giving permission to read and write

mkdir -p /var/log/mysql /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql /var/log/mysql
chmod -R 755 /var/lib/mysql /var/log/mysql

# variables

DB_ROOT_PASS=$(cat ../../../../secrets/db_root_password.txt)
DB_PASSWORD=$(cat ../../../../secrets/db_password.txt)
DB_USER=hes-saqu
DB_NAME=mariadb

echo "=== stating mariadb service ==="
systemctl enable mariadb
systemctl start mariadb

# Launch mysqld in the background
mysqld_safe --skip-networking &
pid="$!"

# Wait until MariaDB is ready
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

echo "=== Securing MariaDB installation ==="
mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
  DELETE FROM mysql.user WHERE User='';
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
EOSQL

echo "=== Creating application database and user ==="
mysql -u root -p"${DB_ROOT_PASS}" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS ${DB_NAME};
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
  GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "=== Shutting down temporary MariaDB ==="
mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown


echo "=== start Mariadb in the foreground (Docker PID1)"
exec mysqld_safe

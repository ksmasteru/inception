#idocker file for mariadb
#
FROM debian:bullseye
  
RUN 	apt-get update && \  	
 	apt-get install -y \
	mariadb-server

COPY ./conf/mariadb_init.sh /tmp/mariadb_init.sh

RUN chmod +x /tmp/mariadb_init.sh

#running script that set up mariadb and run the daemon
RUN sh /tmp/mariadb_init.sh

CMD ["mysql_safe"]

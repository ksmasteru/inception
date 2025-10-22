FROM debian:bookworm-backports

RUN apt update &&\
    apt-get install -y mariadb-server 

RUN apt install -y  vim &&\
    apt install -y sudo 

COPY ./config/my.cnf /etc/mysql/my.cnf 
COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 

COPY ./tools/setup.sh . 

RUN chmod +x setup.sh

CMD ["bash", "setup.sh"]


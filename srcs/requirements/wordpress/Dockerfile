FROM debian:bookworm-backports

RUN apt update && \
    apt install -y \
    php \
    php-fpm \
    php-redis \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    vim \
    curl \
    wget \
    sudo
	  
RUN sudo apt install -y php-fpm

COPY ./tools/setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh

RUN ./usr/local/bin/setup.sh

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD  ["/usr/sbin/php-fpm8.2", "-F"]

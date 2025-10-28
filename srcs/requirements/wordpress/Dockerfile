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

RUN  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD  ["/usr/sbin/php-fpm8.2", "-F"]

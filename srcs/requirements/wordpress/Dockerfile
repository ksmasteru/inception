#BASE IMG FOR php
FROM  php:8.3-fpm
#download and copy wordpress files
RUN apt-get update && apt-get install -y wget \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& mv wordpress/* /var/www/html/ \
 	&& rm -rf latest.tar.gz wordpress
# installing basic php extensions that wordpress needs

RUN apt-get install -y \
	libxml2-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
	libonig-dev\
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql xml zip gd mbstring \
    && rm -rf /var/lib/apt/lists/*

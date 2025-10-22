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

COPY ./tools/setup.sh .

RUN chmod +x setup.sh 

CMD  ["bash", "setup.sh"]

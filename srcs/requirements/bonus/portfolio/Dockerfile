FROM debian:bookworm-backports

RUN apt update -y && \
	apt install -y \
	apache2 \
	vim \
	curl 

RUN sed -i "s/localhost/portfolio/g" /etc/apache2/sites-available/000-default.conf

RUN service apache2 start

COPY ./tools/index.html  ./tools/script.js  ./tools/styles.css /var/www/html

CMD ["/usr/sbin/apachectl","-DFOREGROUND"]

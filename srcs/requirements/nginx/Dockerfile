FROM debian:bookworm-backports

RUN apt update &&\
	apt install -y \
	nginx \
	openssl \
	vim \
	curl \
	wget \
	sudo \
	ftp #for testing ftp service 


RUN apt install -y  vim 

RUN mkdir -p /etc/nginx/ssl &&\
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/private.key \
	-out /etc/nginx/ssl/certificate.crt \
	-subj "/C=MA/L=BNG/O=1337/CN=aelbasri.42.fr"

COPY ./config/nginx.conf /etc/nginx/conf.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

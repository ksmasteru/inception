FROM debian:bookworm-backports

RUN apt update && \
	apt install -y \
	redis-server \
	redis-tools \
	vim \
	curl \
	sudo

RUN sudo sed -i "s/bind 127.0.0.1 -::1/bind wordpress/g" /etc/redis/redis.conf

CMD ["redis-server", "--protected-mode", "no"] 

FROM debian:bookworm-backports

RUN apt update && \
    apt install -y\
	ftp \
	vsftpd \
	vim \
	sudo \
	net-tools

COPY ./tools/setup.sh .
RUN sudo chmod +x setup.sh

#EXPOSE 21

CMD ["bash", "setup.sh"] 

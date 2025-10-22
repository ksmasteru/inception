FROM debian:bookworm-backports

RUN apt update &&\
	apt install -y \
	vim \
	curl 

RUN curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh

RUN service netdata start 

CMD ["netdata" , "-D"]

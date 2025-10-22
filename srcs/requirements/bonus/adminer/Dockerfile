FROM debian:bookworm-backports

RUN apt update -y && \
	apt install -y \
	adminer \
	php

CMD ["php" ,"-S", "adminer:8080", "-t", "/usr/share/adminer/adminer"]

create:
	mkdir ~/data ~/data/wordpress_database/ ~/data/wordpress_files/ 

build:
	docker compose -f ./srcs/docker-compose.yml -p inception build
run:
	docker compose -f ./srcs/docker-compose.yml -p inception up

clean:
	docker compose -f ./srcs/docker-compose.yml -p inception down
	docker image rm wordpress:1337 nginx:1337 mariadb:1337 redis:1337 ftp:1337 portfolio:1337 adminer:1337 netdata:1337
vclear:
	sudo rm -rf ~/data/wordpress_database/* ~/data/wordpress_files/*

rebuild: clean build


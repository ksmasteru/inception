create:
	@mkdir ~/data ~/data/wordpress_database/ ~/data/wordpress_files/ 

build:
	docker compose -f ./srcs/docker-compose.yml build
run:
	docker compose -f ./srcs/docker-compose.yml up

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker image rm wordpress:1337 nginx:1337 mariadb:1337 
vclear:
	sudo rm -rf ~/data/wordpress_database/* ~/data/wordpress_files/*

rebuild: clean build

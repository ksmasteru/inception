create:
	@mkdir ~/data ~/data/wordpress_database/ ~/data/wordpress_files/ 
build:
	sudo docker compose -f ./srcs/docker-compose.yml build
run:
	sudo docker compose -f ./srcs/docker-compose.yml up
clean:
	sudo docker compose -f ./srcs/docker-compose.yml down -v
	sudo docker image rm wordpress:1337 nginx:1337 mariadb:1337
vclear:
	sudo rm -rf ~/data
rebuild: clean build

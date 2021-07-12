#!/bin/bash

read -p "Client nodes: " numClients

cd ..
echo -n > docker-compose.yml

echo -e 'version "3"' >> docker-compose.yml
echo -e 'services:' >> docker-compose.yml
echo -e '  s1:\n    container_name: server1\n    privileged: true' >> docker-compose.yml
echo -e '    tty: true\n    build:\n      context: .' >> docker-compose.yml
echo -e '      dockerfile: Dockerfile_server1\n    hostname: server1' >> docker-compose.yml
echo -e '    networks:\n      - dev' >> docker-compose.yml

for i in $(seq 2 5)
do
	echo -e "  s$i:\n    container_name: server$i\n    privileged: true" >> docker-compose.yml
	echo -e "    tty: true\n    build:\n      context: ." >> docker-compose.yml
	echo -e "      dockerfile: Dockerfile_server$i" >> docker-compose.yml
	echo -e "    depends_on:\n      s1:" >> docker-compose.yml
	echo -e "        condition: service_started" >> docker-compose.yml
	echo -e "    hostname: server$i" >> docker-compose.yml
	echo -e "    networks:\n      - dev" >> docker-compose.yml
done

for i in $(seq 1 $numClients)
do
	echo -e "  c$i:\n    container_name: client$i\n    privileged: true" >> docker-compose.yml
	echo -e "    tty: true\n    build:\n      context: ." >> docker-compose.yml
	echo -e "      dockerfile: Dockerfile_client$i" >> docker-compose.yml
	echo -e "    depends_on:\n      s1:" >> docker-compose.yml
	echo -e "        condition: service_started" >> docker-compose.yml
	echo -e "    hostname: client$i" >> docker-compose.yml
	echo -e "    networks:\n      - dev" >> docker-compose.yml
done

echo -e "\n" >> docker-compose.yml
echo -e "networks:\n  dev:\n    ipam:\n      driver: default" >> docker-compose.yml

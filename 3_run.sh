#!/bin/bash

PRESENTATION_PORT=5000

# Create directory link containers
mkdir -p ${PWD}/data/{php,mysql} &>/dev/null
sudo docker rm -f data-php data-mysql data-nginx-proxy &>/dev/null
sudo docker run --name data-php -v $PWD/data/php:/var/www/html busybox true #&>/dev/null
sudo docker run --name data-mysql -v $PWD/data/mysql:/var/lib/mysql busybox true #&>/dev/null
sudo docker run --name data-nginx-proxy -v $PWD/data/nginx-proxy:/etc/nginx/sites-enabled busybox true

sudo docker rm \
            -f \
            mysql-test \
            apache-php \
            nginx-proxy-test

#DB Layer
sudo docker run \
            -d \
            --name mysql-test \
            --volumes-from data-mysql \
            -t mysql-test

#App Server Layer
sudo docker run \
            -d \
            --name apache-php \
            --volumes-from data-php \
            --link mysql-test:mysql \
            -e MYSQL_ROOT_PASSWORD=toor \
            -t apache-php

#Proxy Layer
sudo docker run \
            -d \
            --name nginx-proxy-test \
            -p ${PRESENTATION_PORT}:80 \
            -p $((PRESENTATION_PORT+1)):443 \
            --volumes-from data-nginx-proxy \
            --link apache-php:upstream \
            -t nginx-proxy-test

echo -e "\nPlease connect to: "
echo "http://localhost:${PRESENTATION_PORT}"
echo "https://localhost:$((PRESENTATION_PORT+1))"

echo -e "\nSleeping for 5 seconds..."
sleep 5
curl http://localhost:${PRESENTATION_PORT}
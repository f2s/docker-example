#!/bin/bash

PRESENTATION_PORT=5000

# Create directory link containers
mkdir -p ${PWD}/data/{php,mysql} &>/dev/null
sudo docker rm -f data-php data-mysql &>/dev/null
sudo docker run --name data-php -v $PWD/data/php:/var/www/html busybox /bin/true #&>/dev/null
sudo docker run --name data-mysql -v $PWD/data/mysql:/var/lib/mysql busybox /bin/true #&>/dev/null


# Startup LAMP
sudo docker rm \
            -f \
            mysql-test apache-php

sudo docker run \
            -d \
            --name mysql-test \
            --volumes-from data-mysql \
            -t mysql-test

sudo docker run \
            -d \
            --name apache-php \
            --volumes-from data-php \
            --link mysql-test:mysql \
            -p ${PRESENTATION_PORT}:80 \
            -e MYSQL_ROOT_PASSWORD=toor \
            -t apache-php


echo "Please connect to http://localhost:${PRESENTATION_PORT}"
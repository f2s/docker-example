#!/bin/bash

read "Are you sure you want to continue? (Y/N)" RESPONSE
[ "${RESPONSE}" != "Y" ] && exit 1

sudo docker rm -f $(sudo docker ps -q)
#sudo docker rm -f $(sudo docker ps -qa)
#sudo docker rmi $(sudo docker images -q)
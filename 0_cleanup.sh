#!/bin/bash

echo "Warning: This will remove all running containers"
echo -n "Are you sure you want to continue? (Y/N)"
read RESPONSE
[ "${RESPONSE}" != "Y" ] && exit 1

sudo docker rm -f $(sudo docker ps -q)
#sudo docker rm -f $(sudo docker ps -qa)
#sudo docker rmi -f $(sudo docker images -q)
#!/bin/bash

which docker || curl http://get.docker.io | sudo bash
which fig || sudo apt-get install -y python-pip && sudo pip install -U fig

# Pull external containers
sudo docker pull scratch
sudo docker pull busybox
sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter


which apt &>/dev/null && {
  export DEBIAN_FRONTEND=noninteractive 
  sudo apt-get update
  sudo apt-get install --fix-missing -y git
} || {
	echo "centos not supported"
	exit 1
}






#docker run --name jira-internalaccess-mysql \
#           --link mysql:linkhost \
#           -p 3306:1234 \
#           -e SRC_PORT=3306 \
#           -d ubuntu:14.04 \
#           bash -c 'apt-get install -y socat; socat TCP-LISTEN:1234,fork TCP:linkhost:${SRC_PORT}'
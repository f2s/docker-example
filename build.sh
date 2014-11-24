#!/bin/bash

# Pull external containers
#sudo docker pull scratch
sudo docker pull busybox
sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

build_list="$(cat build.txt | grep -v '^#')"

for i in ${build_list}; do
  filename="${i}/Dockerfile"
  TAG=$(grep '^#TAG' $filename | sed 's/.*TAG //')
  [ -z "${TAG}" ] && continue
  echo "Building: $i/Dockerfile - TAG: $TAG"

  cd ${i}
  sudo docker build -t ${TAG} .
  cd ..
done
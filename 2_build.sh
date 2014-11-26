#!/bin/bash

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m'


build_list="$(cat build.txt | grep -v '^#')"

for i in ${build_list}; do
  filename="${i}/Dockerfile"
  TAG=$(grep '^#TAG' $filename | sed 's/.*TAG //')
  [ -z "${TAG}" ] && continue
  echo "Building: $i/Dockerfile - TAG: $TAG"

  cd ${i}
  sudo docker build -t ${TAG} . && echo -e "${green}${TAG} - Successfully built${NC}" || echo -e "${red}${TAG} - Error during build${NC}"
  cd ..
done
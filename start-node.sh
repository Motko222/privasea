#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
cd $path
source config

docker stop $folder
docker rm $folder

docker pull privasea/node-calc:$NODE_VERSION

docker run -d \
  --name $folder \
  --restart always \
  -p 8181:8181 \
  -e HOST=$IP \
  -e KEYSTORE=$KEY \
  -e KEYSTORE_PASSWORD=$PASS \
  -v /root/privesea-key:/app/config privasea/node-calc:$NODE_VERSION

./log.sh

#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
cd $path
source config

docker stop $folder
docker rm $folder

version=v0.0.1

docker pull privasea/node-calc:$version

docker run -d \
  --name $folder \
  --restart always \
  -p 8181:8181 \
  -e HOST=$IP \
  -e KEYSTORE=$KEY \
  -e KEYSTORE_PASSWORD=$PASS \
  -v /root/privesea-key:/app/config privasea/node-calc:$version

./log.sh

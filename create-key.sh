#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

version=v0.0.1

apt-get install docker.io -y
docker pull privasea/node-client:$version
mkdir -p /root/privasea-keys
docker run -it -v /root/privasea-keys:/app/keys privasea/node-client:$version account
key_file=$(ls /root/privasea-keys)

echo ----- BACKUP THIS KEY !!! -------------------
echo "Key file name:"
echo $key_file
echo "File content:"
cat /root/privasea-keys/$key_file
echo
echo -----------------------------------------------

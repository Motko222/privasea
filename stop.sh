#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

echo "Stopping containers..."
docker stop $folder
echo "Removing containers..."
docker rm $folder

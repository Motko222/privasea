#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
json=~/logs/report-$folder
source ~/.bash_profile

cd $path
source config

docker_status=$(docker inspect $folder | jq -r .[].State.Status)
version=$(docker ps -a --no-trunc | grep $folder | awk -F 'privasea/node-calc:' '{print $2}' | awk '{print $1}')

case $docker_status in
  running) status=ok; message="" ;;
  restarting) status=warning; message="docker is restarting" ;;
  *) status="error"; message="docker not running" ;;
esac

cat >$json << EOF
{
  "updated":"$(date --utc +%FT%TZ)",
  "measurement":"report",
  "tags": {
   "id":"$folder",
   "machine":"$MACHINE",
   "grp":"node",
   "owner":"$OWNER"
  },
  "fields": {
   "network":"testnet",
   "chain":"privasea",
   "status":"$status",
   "message":"$message",
   "docker_status":"$docker_status",
   "version":"$version"
  }
}
EOF

cat $json | jq

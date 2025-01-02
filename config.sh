#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
cd $path

[ -f config ] || cp config.sample config

source config
[ -d /root/hyperlane_db_$CHAIN ] || mkdir -p /root/hyperlane_db_$CHAIN && chmod -R 777 /root/hyperlane_db_$CHAIN
nano config

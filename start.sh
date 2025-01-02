#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
source config

docker run -d \
  -it \
  --name $folder \
  --mount type=bind,source=/root/hyperlane_db_$CHAIN,target=/hyperlane_db_$CHAIN \
  gcr.io/abacus-labs-dev/hyperlane-agent:agents-v1.0.0 \
  ./validator \
  --db /hyperlane_db_$CHAIN \
  --originChainName $CHAIN \
  --reorgPeriod 1 \
  --validator.id $NAME \
  --checkpointSyncer.type localStorage \
  --checkpointSyncer.folder $CHAIN \
  --checkpointSyncer.path /hyperlane_db_$CHAIN/$CHAIN_checkpoints \
  --validator.key $PK \
  --chains.$CHAIN.signer.key $PK \
  --chains.$CHAIN.customRpcUrls $RPC

cd $path
./log.sh

#!/bin/bash
ARCH=$(dpkg --print-architecture)
echo $ARCH
cd "docker-$1"
docker build  -t yuxianggao/$1:$ARCH .
docker push yuxianggao/$1:$ARCH
# docker run --rm weshigbee/manifest-tool push from-spec manifest.yaml

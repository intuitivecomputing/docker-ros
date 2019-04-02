#!/bin/sh
ARCH=$(dpkg --print-architecture)
echo $ARCH
cd $1
docker build  -t yuxianggao/$1:$ARCH .
docker push yuxianggao/$1:$ARCH
manifest-tool push from-spec manifest.yaml

#!/bin/bash
ARCH=$(dpkg --print-architecture)
echo $ARCH
echo "Usage [container name] [docker name] [display]"
if [[ ${3:-0} = 0 ]]; then
  docker run -it --rm \
    --net=host \
    --privileged \
    --name $1 \
    --volume /dev:/dev \
    yuxianggao/$2:$ARCH \
    bash
else
  xhost +local:root
  docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:$HOME/.Xauthority \
    --net=host \
    --privileged \
    --name $1 \
    --volume /dev:/dev \
    yuxianggao/$2:$ARCH \
    bash
fi

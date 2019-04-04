#!/bin/bash

function usage {
    echo "usage: $0 image1 image2 ... imageN"
    echo "Give the images to build. If no image is given, all folders in /dockers will be built."
    echo "Arguments:"
    echo "  -h|--help: Usage"
    echo "  -d|--dir: dockers directory. Default: dockers"
    echo "  -r|--ros0distro: ros distibution. Default: kinetic"
    exit 1
}

ARCH=$(dpkg --print-architecture)
ROS_DISTRO="kinetic"
DOCKER_DIR="dockers"

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      usage
      ;;
    -r|--ros-distro)
      ROS_DISTRO="$1"
      break
      ;;
    -d|--dir)
      DOCKER_DIR="$1"
      break
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      usage
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

function build_all {
  for FOLDERNAME in $DOCKER_DIR/*; do
    if [[ -d $FOLDERNAME ]]; then
      SUBFOLDER=$(basename "$FOLDERNAME")
      echo "[Building yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}]"
      eval "docker build -t yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH} --build-arg ROS_DISTRO=${ROS_DISTRO} --build-arg ARCH=${ARCH} dockers/${SUBFOLDER}"
      echo "[Pushing yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}]"
      eval "docker push yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}"
    fi
  done
}

function build {
  for FOLDERNAME in $(basename "$DOCKER_DIR")/*; do
    SUBFOLDER=$(basename "$FOLDERNAME")
    if [[ ( -d $FOLDERNAME ) && ( $SUBFOLDER = $1) ]]; then
      echo "[Building yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}]"
      eval "docker build -t yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH} --build-arg ROS_DISTRO=${ROS_DISTRO} --build-arg ARCH=${ARCH} dockers/${SUBFOLDER}"
      echo "[Pushing yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}]"
      eval "docker push yuxianggao/${SUBFOLDER}:${ROS_DISTRO}-${ARCH}"
    fi
  done
}

function main {
  echo "$1"
  if [[ $# -eq 0 ]]; then
      echo "Building all"
      build_all
  else
    for folder in "$@"
    do
      echo "Building $folder"
      build "$folder"
    done
  fi
}

main $PARAMS
# # docker run --rm weshigbee/manifest-tool push from-spec manifest.yaml

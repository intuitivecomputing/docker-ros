#!/bin/bash
set -a
DOCKER_ROS_DISTRO="kinetic"
DOCKER_ARCH="$(dpkg --print-architecture)"

function usage {
    echo "Usage:"
    echo "Give the images to build. If no image is given, all folders in /dockers will be built."
    echo "Arguments:"
    echo "  -h|--help: Usage"
    echo "  -s|--start: Run dockers"
    echo "  -b|--build: Start with build"
    echo "  -a|--attached: Run in attached mode to see output"
    echo "  -e|--end: Stop dockers"
    exit 1
}


function end {
  docker-compose down
  exit 1
}

ATTACHED="0"


PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      usage
      ;;
    -s|--start)
      CMD="docker-compose up"
      shift
      ;;
    -b|--build)
      CMD="$CMD --build"
      shift
      ;;
    -a|--attached)
      ATTACHED="1"
      shift
      ;;
    -e|--end)
      end
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

function main {
  if [[ ! -z $CMD ]]; then
    echo "Starting docker-compile"
    if [[ $1 = "0" ]]; then
      CMD="$CMD -d"
    fi
  fi
  eval "$CMD"
}

main $ATTACHED

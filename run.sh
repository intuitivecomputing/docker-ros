#!/bin/bash
set -a
DOCKER_ROS_DISTRO="kinetic"
DOCKER_ARCH="$(dpkg --print-architecture)"

function usage {
    echo "usage:"
    echo "Give the images to build. If no image is given, all folders in /dockers will be built."
    echo "Arguments:"
    echo "  -h|--help: Usage"
    echo "  -s|--start: Run dockers"
    echo "  -d|--detached: Run in detached mode (1: True, 0: False). Default: 1"
    echo "  -e|--end: Stop dockers"
    exit 1
}

function start_detached {
  docker-compose up -d
  exit 1
}

function start {
  docker-compose up
}

function end {
  docker-compose down
  exit 1
}

PARAMS=""
while (( "$#" )); do
  echo "$1"
  case "$1" in
    -h|--help)
      usage
      ;;
    -s|--start)
      RUN="1"
      break
      ;;
    -d|--detached)
      DETACHED="$1"
      break
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



echo "$RUN"
function main {
  if [[ ! -z $1 ]]; then
    echo "Starting docker-compile"
    if [[ $2 = 0 ]]; then
      start
    else
      start_detached
    fi
  fi
}

main $RUN $DETACHED

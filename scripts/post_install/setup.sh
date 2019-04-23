#!/bin/bash
set -ax

sudo apt update
sudo apt install -qqy fabric
cp txdocker /usr/local/bin/
chmod +x /usr/local/bin/txdocker

. scripts/post_install/install_docker.sh
main
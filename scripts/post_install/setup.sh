#!/bin/bash
set -ax

# maximum performace
sudo jetson_clocks

# env
echo "export ROS_MASTER_URI=http://192.168.1.116:11311" >> ${HOME}/.bashrc
echo "export ROS_IP=$(hostname -I | cut -f1 -d' ')" >> ${HOME}/.bashrc
echo "export DOCKER_ROS_DISTRO=kinetic" >> ${HOME}/.bashrc
echo "export DOCKER_ARCH=$(dpkg --print-architecture)" >> ${HOME}/.bashrc

# git
git config --global credential.helper 'cache --timeout 7200'
git config --global user.name "Yuxiang Gao"
git config --global user.email yuxianggao@jhu.edu

sudo apt update
sudo apt -qqy upgrade
sudo apt install -qqy fabric vim tmux terminator
# docker gpu access
sudo cp txdocker /usr/local/bin/
chmod +x /usr/local/bin/txdocker
# install docker
. install_docker.sh
main

# build kernel
. kernel_build.sh

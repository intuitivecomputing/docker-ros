#!/bin/bash
set -ax

function install_docker {
    sudo apt-get remove -y docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -qqy\
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
        "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    sudo apt-get update
    sudo apt-get install -qqy docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker ${USER}
}

function install_docker_compose {
    sudo apt-get install -qqy libffi-dev python-openssl python-pip
    sudo pip uninstall docker-compose
    #curl -sSL https://bootstrap.pypa.io/get-pip.py | sudo python
    sudo pip install docker-compose
}

function main {
    install_docker
    install_docker_compose
    sudo docker run --rm -it arm64v8/ubuntu:16.04 cat /etc/issue
    # sudo shutdown -r now
}

# main

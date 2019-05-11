#!/bin/bash
CURR_PATH=$PWD
sudo apt update 
sudo apt install -y libhidapi-libusb0 libturbojpeg libncurses5-dev
mkdir ./tmp
cd ./tmp
wget -c https://developer.nvidia.com/embedded/dlc/l4t-sources-32-1-jetson-nano -O Jetson-Nano-public_sources.tbz2
tar -vxjf Jetson-Nano-public_sources.tbz2
cd public_sources && tar -vxjf kernel_src.tbz2
cp ${CURR_PATH}/my_config kernel/kernel-4.9/.config
cd kernel/kernel-4.9 && cp /lib/firmware/tegra21x_xusb_firmware ./firmware/
patch -p1 < ${CURR_PATH}/realsense-hid-ubuntu-xenial-Ubuntu-hwe-4.8.0-58.63_16.04.1.patch
# zcat /proc/config.gz > .config 
#make menuconfig
make -j$(nproc)
sudo make modules_install
sudo mv /boot/Image /boot/Image-original
sudo cp ./arch/arm64/boot/Image /boot/Image


# Dockers for ROS
## Prerequisites 
1. Install Docker Engine and Docker Compose
2. If you are running this on a Raspberry Pi, you need to [add swap](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation_raspbian.md) for building `librealsense`:

Initial value is 100MB, but we need to build libraries so initial value isn't enough for that. In this case, need to switch from 100 to 2048 (2GB).

```
$ sudo vim /etc/dphys-swapfile
CONF_SWAPSIZE=2048

$ sudo /etc/init.d/dphys-swapfile restart swapon -s
```

3. [Use docker without sudo](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

4. [Fix broken docker-compose](https://www.tomhanoldt.info/blog/dev/docker/docker-on-raspberry-with-gui/)
As docker-compose makes things more reproducable but is broken in the actual hypriot image, we will fix this by typing this in to the raspberry terminal:
```
sudo easy_install --upgrade pip
sudo pip uninstall docker docker-compose -y

sudo pip install requests==2.20.1
sudo pip install docker==3.7.2
sudo pip install docker-compose==1.23.0
```
5. We use `Fabric` to streamline build and development, to install `Fabric`:
```
pip install Fabric3
#or
sudo apt install fabric
```

## Conventions
The directory should look like this
```
.
+-- docker-compose.yml
+-- dockers
|   +-- docker-ros-{name1}
|   |   +-- Dockerfile
|   |   +-- ...
|   +-- docker-ros-{name2}
|   |   +-- Dockerfile
|   |   +-- ...
+-- packages
|   +-- package1
|   +-- package2
```
All dockers should reside in the `dockers` folder, and the packages should be cloned into the `packages` folder as submodules and mounted to the containers.

## Basic Usage
### Building
We provide a build script for building and pushing images, usage:
```
usage: ./build.sh image1 image2 ... imageN
Give the images to build. If no image is given, all folders in /dockers will be built.
Arguments:
  -h|--help: Usage
  -d|--dir: dockers directory. Default: dockers
  -r|--ros0distro: ros distibution. Default: kinetic

```
Examples:
```
./build.sh ros-gui ros-master #build specific images
./build.sh #build all 
```

## docker-ros-realsense 
Docker for d415/d435 using ROS
Dockerized ROS environment with Realsense support.


### Credits
This project is inspired by [docker-ros-d415](https://github.com/iory/docker-ros-d415), [gobbit project](https://github.com/frankjoshua/gobbit.git) and [ROS Docker Tutorials](https://docs.docker.com/samples/library/ros/).


### Using stand-alone container with gui
```
xhost +local:root

docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:$HOME/.Xauthority \
    --net=host \
    yuxiang-gao/ros-gui \
    /bin/bash
```
### Using Docker Compose
1. Bring up the containers:
`docker-compose up -d`
2. Check status
`docker ps`
3. To enter interactive mode
```
$ docker exec -it master bash
$ source /ros_entrypoint.sh
```
4. Bring down the containers:
`Docker-compose down`

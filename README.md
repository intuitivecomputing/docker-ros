# Dockers for ROS
## Prerequisites 
Run `script/post_install/setup.sh`. It does three things:
1. We use `Fabric` to streamline build and development, to install `Fabric`:
```
pip install Fabric3
#or
sudo apt install fabric
```
2. Expose GPU to docker
```bash
cp txdocker /usr/local/bin/
chmod +x /usr/local/bin/txdocker
```
And use it as docker command.

3. Install Docker Engine and Docker Compose

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
We provide a `build.sh` script for building and pushing images, usage:
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
### Running
We provide a `run.sh` script for launching images, usage:
```
Usage:
Give the images to build. If no image is given, all folders in /dockers will be built.
Arguments:
  -h|--help: Usage
  -s|--start: Run dockers
  -b|--build: Start with build
  -a|--attached: Run in attached mode to see output
  -e|--end: Stop dockers

```
Examples:
```
./run.sh -s #start dockers
./run.sh -s -b #build and start dockers
./run.sh -s -a #start dockers in attached mode
./run.sh -e #end dockers
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

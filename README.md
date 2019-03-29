# Docker for d415/d435 using ROS
Dockerized ROS environment with Realsense support.


## Credits
This project is inspired by [docker-ros-d415](https://github.com/iory/docker-ros-d415) and [ROS Docker Tutorials](https://docs.docker.com/samples/library/ros/).

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
## Usage
### Build the container
```docker build -t yuxianggao/docker-ros-realsense:raspi-d435i ./docker```
### Using stand-alone container
```
docker network create ros-net

docker run -it --rm \
    --net=ros-net \
    --privileged \
    -p 11311:11311 \
    --volume /dev:/dev \
    --name ros-master \
    ros:kinetic-ros-base \
    roscore

docker run -it --rm \
    --net=ros-net \
    --privileged \
    --volume /dev:/dev \
    --name realsense \
    --env ROS_HOSTNAME=realsense \
    --env ROS_MASTER_URI=http://ros-master:11311 \
    yuxianggao/docker-ros-realsense:raspi-d435i \
    roslaunch realsense2_camera rs_rgbd.launch
```
Use host's network
```
docker run -it --rm \
    --net=host \
    --privileged \
    --volume /dev:/dev \
    --name realsense \
    yuxianggao/docker-ros-realsense:raspi-d435i \
    roslaunch realsense2_camera rs_rgbd.launch initial_reset:=true
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
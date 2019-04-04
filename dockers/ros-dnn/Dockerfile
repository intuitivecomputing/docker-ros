ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}-robot
ARG ROS_DISTRO

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-vision-opencv \
    ros-${ROS_DISTRO}-dnn-detect \
    ros-${ROS_DISTRO}-compressed-image-transport &&\
    apt-get -y clean &&\
    apt-get -y purge &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# CMD ["roslaunch", "--wait", "dnn_detect", "dnn_detect.launch", "camera:=/usb_cam", "image:=image_raw" ]

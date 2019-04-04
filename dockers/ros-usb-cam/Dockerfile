ARG ROS_DISTRO
FROM ros:kinetic-robot
ARG  ROS_DISTRO=kinetic

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-usb-cam \
    ros-${ROS_DISTRO}-uvc-camera \
    ros-${ROS_DISTRO}-compressed-image-transport &&\
    apt-get -y clean &&\
    apt-get -y purge &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["rosrun", "usb_cam", "usb_cam_node", "_width:=640", "_height:=480", "_fps:=30", "_camera_frame_id:=camera_link", "_camera_info_url:=file:///calibration.yaml"]
COPY ./calibration.yaml /

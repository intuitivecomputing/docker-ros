ARG ROS_DISTRO=kinetic
>>>>>>> df1db2389d41d6f275c855e6757b45bc9ee39aab
FROM ros:${ROS_DISTRO}-ros-core
ARG ROS_DISTRO

LABEL maintainer="Yuxiang Gao ygao73@jhu.edu.com"

VOLUME [ "/dev", "/tmp/.X11-unix", "$HOME/.Xauthority" ]

ENV DISPLAY :0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -qqy \
    tmux \
    git \
    vim \
    ros-${ROS_DISTRO}-rviz \
    ros-${ROS_DISTRO}-rqt \
    ros-${ROS_DISTRO}-rgbd-launch \
    ros-${ROS_DISTRO}-image-transport-plugins \
    ros-${ROS_DISTRO}-image-transport && \
    rm -rf /var/lib/apt/lists/*

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]

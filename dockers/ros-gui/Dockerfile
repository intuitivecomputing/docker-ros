ARG ROS_DISTRO
ARG ARCH
FROM ros:${ROS_DISTRO}-ros-core
ARG ROS_DISTRO
ARG ARCH
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

RUN /bin/bash -c 'echo "$ARCH"'
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]

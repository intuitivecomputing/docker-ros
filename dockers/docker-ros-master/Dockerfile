ARG ROS_DISTRO=kinetic
FROM osrf/ros:kinetic-desktop-full
ARG ROS_DISTRO
LABEL maintainer="Yuxiang Gao ygao73@jhu.edu.com"

RUN apt-get update && \
    apt-get install -qqy x11-apps \
    tmux \
    wget \
    python-rosinstall \
    python-catkin-tools && \
    apt-get upgrade -y && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["roscore"]

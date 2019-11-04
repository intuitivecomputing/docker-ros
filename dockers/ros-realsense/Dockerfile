
ARG ROS_DISTRO=kinetic
FROM ros:${ROS_DISTRO}-ros-core

ARG ROS_DISTRO
ARG LIBREALSENSE_VERSION=2.25.0
ARG ROSREALSENSE_VERSION=2.2.8

LABEL maintainer="Yuxiang Gao ygao73@jhu.edu.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt install -qqy \
  # x11-apps \
  tmux \
  curl \
  wget \
  python-rosinstall \
  python-catkin-tools \
  ros-${ROS_DISTRO}-rgbd-launch \
  ros-${ROS_DISTRO}-image-transport-plugins \
  ros-${ROS_DISTRO}-image-transport && \
  rm -rf /var/lib/apt/lists/*


RUN wget https://github.com/IntelRealSense/librealsense/archive/v${LIBREALSENSE_VERSION}.tar.gz
RUN tar xvzf v${LIBREALSENSE_VERSION}.tar.gz && \
  mkdir -p librealsense-${LIBREALSENSE_VERSION}/build
RUN apt update && \
  apt install -y \
  libusb-1.0-0 \
  libusb-1.0-0-dev \
  freeglut3-dev \
  libgtk-3-dev \
  libglfw3-dev

RUN cd librealsense-${LIBREALSENSE_VERSION}/build; cmake ..
RUN cd librealsense-${LIBREALSENSE_VERSION}/build; make -j4; make install

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src && \
  git clone --depth 1 --branch ${ROSREALSENSE_VERSION} https://github.com/intel-ros/realsense
RUN cd catkin_ws; rosdep install -r -y --from-paths src --ignore-src


RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd catkin_ws; catkin build

# RUN touch /root/.bashrc && \
#     # machine_ip=(`hostname -I`) && \
#     # echo "export ROS_IP=${machine_ip[0]}" >> /root/.bashrc && \
#     # echo "export ROS_MASTER_URI=http://localhost:11311" >> /root/.bashrc && \
#     echo "source ~/catkin_ws/devel/setup.bash" >> /root/.bashrc

RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

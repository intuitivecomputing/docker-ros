FROM nvcr.io/nvidia/l4t-base:r32.2.1
LABEL maintainer "Annie Mao <amao1@jhu.edu>"

ENV DEBIAN_FRONTEND=noninteractive

# Setup the ZED SDK
RUN apt-get update -y && apt-get upgrade -y && apt-get autoremove -y && \
    apt-get install --no-install-recommends lsb-release wget less udev sudo apt-transport-https libqt5xml5 libxmu-dev libxi-dev -y && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && \ 
    wget --no-check-certificate -O ZED_SDK_Jetson_4_2.run https://download.stereolabs.com/zedsdk/2.8/jetson_jp42 && \
    chmod +x ZED_SDK_Jetson_4_2.run ; ./ZED_SDK_Jetson_4_2.run silent && \
    rm ZED_SDK_Jetson_4_2.run && \
    rm -rf /var/lib/apt/lists/*

# Setup ROS
RUN apt-get update -y && apt-get install -y gnupg
RUN apt-get update -y && \
    apt-get install -y tzdata && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update -y && \
    apt-get install ros-melodic-desktop-full python-rosinstall python-rosinstall-generator python-wstool build-essential nano cmake usbutils git -y --allow-unauthenticated && \
	apt-get update -y && apt-get install git && \
    rm -rf /var/lib/apt/lists/*

## setup ros env
RUN rosdep init && rosdep update && echo "source \"/opt/ros/melodic/setup.bash\"" >> ~/.bashrc && \
    mkdir -p /catkin_ws/src

RUN cd /catkin_ws/src && \
    wget --no-check-certificate -O zed-ros-wrapper.zip https://github.com/stereolabs/zed-ros-wrapper/archive/master.zip && \
    unzip zed-ros-wrapper.zip && rm zed-ros-wrapper.zip

RUN ./bin/bash -c 'source /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make; source devel/setup.bash'

WORKDIR /catkin_ws

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

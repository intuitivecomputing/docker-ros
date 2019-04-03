FROM osrf/ros:kinetic-desktop-full

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -qqy x11-apps \
    wget \
    python-rosinstall \
    python-catkin-tools && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/
ENV DISPLAY :0

RUN mkdir -p /catkin_ws/src
RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd catkin_ws; catkin build
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

RUN touch /root/.bashrc && \
    echo "source /catkin_ws/devel/setup.bash" >> /root/.bashrc

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

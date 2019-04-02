FROM osrf/ros:kinetic-desktop-full

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -qqy x11-apps && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/
ENV DISPLAY :0

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

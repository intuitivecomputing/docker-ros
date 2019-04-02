FROM ros:kinetic

RUN apt-get update \
    apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
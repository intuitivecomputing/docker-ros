FROM yuxianggao/ros-master

LABEL maintainer="Yuxiang Gao ygao73@jhu.edu.com"
VOLUME [ "/tmp/.X11-unix", "$HOME/.Xauthority" ]
ENV DISPLAY :0

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]

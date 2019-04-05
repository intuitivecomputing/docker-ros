#!/bin/bash
set -e

# machine_ip=(`hostname -I`)
# echo "export ROS_IP=${machine_ip[0]}" >> /root/.bashrc
# echo "export ROS_MASTER_URI=http://localhost:11311" >> /root/.bashrc

# setup ros environment
# SETUP="/opt/ros/$ROS_DISTRO/setup.bash"
if [ -z "${SETUP}" ]; then
    source "/catkin_ws/devel/setup.bash"
    echo "source /catkin_ws/devel/setup.bash" >> $HOME/.bashrc
else
    source $SETUP
fi

exec "$@"

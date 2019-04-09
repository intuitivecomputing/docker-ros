#!/bin/bash
set -e

# machine_ip=(`hostname -I`)
# echo "export ROS_IP=${machine_ip[0]}" >> /root/.bashrc
# echo "export ROS_MASTER_URI=http://localhost:11311" >> /root/.bashrc

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> $HOME/.bashrc

# http://wiki.ros.org/ROS/NetworkSetup
# echo "server S{chrony-server} minpoll 0 maxpoll 5 maxdelay .05" >> /etc/chrony/chrony.conf
exec "$@"

#!/bin/bash
# cuda based ros
# Workspace setup
# v 0.1


echo "Setting up workspace."

USERNAME=$1
EMAIL=$2

if [ "$USERNAME" != "" ] || [ "$EMAIL" != "" ];
then
  
  source ~/.bashrc
  mkdir -p ~/ros_ws/src
	
  cd ~/ros_ws/src  && catkin_init_workspace
  cd ~/ros_ws && catkin_make

  mkdir -p ~/ros_ws/src/cwru
  mkdir -p ~/ros_ws/src/ros_libs
  mkdir -p ~/ros_ws/src/student_code

  git config --global user.name "$USERNAME"
  git config --global user.email "$EMAIL"

  cd ~/ros_ws/src/cwru && git clone https://github.com/cwru-robotics/cwru_msgs.git

  cd ~/ros_ws && catkin_make
  cd ~/ros_ws && catkin_make install
  
  echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
  
  source ~/.bashrc
  
  rosdep update
  
else
	echo "USAGE: ./setup_workspace_376 github_username github_email@email.com"

fi
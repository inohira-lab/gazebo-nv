# docker build -t einohira:gazebo-nv-18 .
# refer to https://gitlab.com/nvidia/container-images/samples/-/blob/master/opengl/ubuntu16.04/glxgears/Dockerfile
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

WORKDIR /root

### BEGIN from https://github.com/osrf/docker_images/blob/master/ros/melodic/ubuntu/bionic/ros-core/Dockerfile

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -q -y tzdata apt-utils && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list

# RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN [ "/bin/bash", "-c", "set -o pipefail && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -" ]

RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic
    
# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

### END

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-melodic-robot \
    ros-melodic-simulators \
    ros-melodic-navigation \
    ros-melodic-gmapping \
    ros-melodic-teleop-twist-keyboard \
    ros-melodic-gazebo-ros-control \
    ros-melodic-ros-controllers \
    mesa-utils \
    python-pip \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
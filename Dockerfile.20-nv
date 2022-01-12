# einohira/ros:gazebo-nv-20
# refer to https://gitlab.com/nvidia/container-images/samples/-/blob/master/opengl/ubuntu16.04/glxgears/Dockerfile
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

WORKDIR /root

# avoid keyboard configuration
ENV DEBIAN_FRONTEND noninteractive

### BEGIN from https://github.com/osrf/docker_images/blob/master/ros/ardent/ubuntu/xenial/ros-core/Dockerfile
### https://github.com/osrf/docker_images/blob/master/ros/noetic/ubuntu/focal/ros-core/Dockerfile

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO noetic

# label ros packages
LABEL sha256.ros-noetic-ros-core=4586cdeb59ec4fc87968f4013a839b78e71a262d3bbc7c60ba2b5befbc8d0928

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-core=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

### END

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-noetic-robot \
    ros-noetic-simulators \
    ros-noetic-navigation \
    ros-noetic-gmapping \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-gazebo-ros-control \
    ros-noetic-ros-controllers \
    mesa-utils \
    # python-pip \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
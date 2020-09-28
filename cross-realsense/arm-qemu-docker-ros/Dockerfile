FROM arm32v7/ros:melodic-ros-core-bionic

ENV DEBIAN_FRONTEND noninteractive

# weitere
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
      apt-utils \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
    less nano iputils-ping \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Rest von ROS
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
      ros-melodic-desktop-full \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# gebraucht von realsense-ros
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
    ros-melodic-ddynamic-reconfigure \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Vorkompilierte Abhängigkeiten von realsense-ros (librealsense) holen
COPY ./copydir/lib/ /usr/local/lib/
COPY ./copydir/include/ /usr/local/include/
COPY ./copydir/bin/ /usr/local/bin/

# Rest aufsetzen
RUN echo root:root | chpasswd

RUN useradd -m idein \
 && echo idein:idein | chpasswd \
 && adduser idein sudo \
 && echo 'idein ALL=NOPASSWD: ALL' >> /etc/sudoers.d/idein

USER idein
WORKDIR /home/idein
ENV HOME /home/idein

ENV PATH /home/idein/.local/bin:$PATH
RUN echo "export PATH=$PATH" >> /home/idein/.bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> /home/idein/.bashrc


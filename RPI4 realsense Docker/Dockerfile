FROM arm32v7/ros:melodic-perception-bionic

ARG DEBIAN_FRONTEND=noninteractive

# apt-utils # ohne recommends | ohne update anderer Packete
RUN apt-get update \
 && apt-get install -y \
      apt-utils \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Packete updaten
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# gebraucht von realsense-ros
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
    ros-melodic-ddynamic-reconfigure \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# nützlich
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
    less nano iputils-ping iproute2 \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# user aufsetzen
RUN echo root:root | chpasswd
RUN useradd -m idein \
 && echo idein:idein | chpasswd \
 && adduser idein sudo \
 && echo 'idein ALL=NOPASSWD: ALL' >> /etc/sudoers.d/idein
USER idein
ENV HOME /home/idein
WORKDIR /home/idein/realsense-ros_ws/install
ENV PATH /home/idein/.local/bin:$PATH

# ROS voll aufsetzen #erst nach User gesetzt
RUN rosdep update

# Ab hier Befehle, die nicht lange dauern.

# Vorkompilierte Abhängigkeiten von realsense-ros (librealsense) holen
#COPY ./copydir/lib/ /usr/local/lib/
#COPY ./copydir/include/ /usr/local/include/
#COPY ./copydir/bin/ /usr/local/bin/

#COPY ["./realsense-rs_ws__install/", "/home/idein/realsense-ros_ws"]
RUN echo "export PATH=$PATH" >> /home/idein/.bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> /home/idein/.bashrc
RUN echo "source /home/idein/realsense-ros_ws/install/setup.bash" >> /home/idein/.bashrc
RUN echo '\n\
if [ -d "/usr/local/lib" ] ; then \n\
LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" \n\
fi' >> /home/idein/.profile
RUN echo "sudo ldconfig" >> /home/idein/.bashrc

COPY ["./openDocker.bash", "/home/idein/openDocker.bash"]
CMD ["/home/idein/openDocker.bash"]

#RPI4


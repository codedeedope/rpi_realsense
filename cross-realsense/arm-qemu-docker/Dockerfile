FROM arm32v7/ubuntu:bionic

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

# gebraucht von librealsense
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
      sudo wget curl \
      gcc g++ cmake autoconf automake libtool libtool-bin build-essential \
      pkg-config bzip2 unzip xz-utils \
      make libssl-dev locales ca-certificates \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --install-recommends \
    xserver-xorg-core \
    xserver-xorg xserver-xorg-video-all \
    xserver-xorg-input-all libwayland-egl1-mesa \
    git libssl-dev libusb-1.0-0-dev pkg-config \
    libgtk-3-dev libglfw3-dev libgl1-mesa-dev \
    libglu1-mesa-dev libpthread-stubs0-dev \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

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
CMD ["/bin/bash"]


FROM ubuntu18.04

RUN apt-get update -y && \
    apt-get install -y \
    wget \
    vim \
    git \
    curl \
    build-essential \
    cmake \
    libblas-dev \
    libboost-all-dev \
    liblapack-dev \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    qt5-default \
    qtmultimedia5-dev \
    libqt5charts5 \
    libqt5charts5-dev \
    pulseaudio \
    pkg-config \
    zip \
    g++ \
    zlib1g-dev \
    unzip \
    libcurl4-openssl-dev \
    tree \
    libxcursor-dev \
    libglm-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev \
    mesa-utils \
    net-tools \
    vlan \
    gdb \
    arp-scan \
    geographiclib-tools \
    libgeographic-dev \
    libgdal-dev \
    python-gdal \
    gdal-bin \
    libpdal-dev \
    pdal \
    libpdal-plugin-python \
    libudev-dev \
    python && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

COPY installers /home/installers
RUN bash /home/installers/install_bazel.sh
RUN bash /home/installers/install_dependency.sh
RUN bash /home/installers/post_install.sh

WORKDIR /work

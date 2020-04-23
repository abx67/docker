FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

RUN apt-get update -y \
 && apt-get install -y \
    wget \
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
    pkg-config \
    zip \
    g++ \
    zlib1g-dev \
    unzip \
    libcurl4-openssl-dev \
    libxcursor-dev \
    libglm-dev \
    libglu1-mesa-dev \
    libudev-dev \
    freeglut3-dev \
    mesa-common-dev \
    mesa-utils \
    geographiclib-tools \
    libgeographic-dev \
    python \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

COPY installers /home/installers
RUN bash /home/installers/install_dependency.sh

WORKDIR /work


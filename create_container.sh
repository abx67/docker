#!/usr/bin/env bash

# Create container with specified container name

# Fail on first error.
set -e

. ./docker/config_docker.sh

CONTAINER_NAME=$1

if [ -z "$CONTAINER_NAME" ]
then
  echo "Use default container name: ${DEFAULT_CONTAINER_NAME}"
  CONTAINER_NAME=${DEFAULT_CONTAINER_NAME}
fi

CUR_DIR="$(pwd)"

docker container create -it \
--name ${CONTAINER_NAME} \
--privileged \
-e DISPLAY=$DISPLAY \
-v ${CUR_DIR}:/work \
-v $HOME/.cache:/root/.cache \
-v /tmp:/tmp \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev:/dev \
-v /media:/media \
-v $HOME/.ssh:/root/.ssh \
-v $HOME/.jfrog:/root/.jfrog \
-e PULSE_SERVER=unix:/run/user/1000/pulse/native \
--device /dev/snd \
--net host \
--shm-size 2G \
--pid=host \
${REPO_WITH_DEFAULT_TAG} /bin/bash

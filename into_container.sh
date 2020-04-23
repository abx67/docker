#!/usr/bin/env bash

# Usage: Go into the specified container

# Fail on first error.
set -e

. ./docker/config_docker.sh

CONTAINER_NAME=$1

if [ -z "$CONTAINER_NAME" ]
then
  echo "Use default container name: ${DEFAULT_CONTAINER_NAME}"
  CONTAINER_NAME=${DEFAULT_CONTAINER_NAME}
fi

docker start ${CONTAINER_NAME}
docker exec -it ${CONTAINER_NAME} /bin/bash

#!/usr/bin/env bash

# Remove a specified container by name

# Fail on first error.
set -e

. ./docker/config_docker.sh

CONTAINER_NAME=$1

if [ -z "$CONTAINER_NAME" ]
then
  CONTAINER_NAME=${DEFAULT_CONTAINER_NAME}
fi

echo "Remove container ${CONTAINER_NAME}"

docker rm --force ${CONTAINER_NAME}

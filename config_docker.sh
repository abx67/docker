#!/usr/bin/env bash

# The common config file for docker bash tools
REPO=ubuntu
ARCH=$(uname -m)
TIME=$(date +%Y%m%d_%H%M)

REPO_WITH_DEFAULT_TAG="${REPO}:18.04"
# REPO_WITH_LATEST_TAG="${REPO}:latest"

DEFAULT_CONTAINER_NAME="ubuntu-dev"

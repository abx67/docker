#!/usr/bin/env bash

. ./docker/config_docker.sh

DOCKERFILE="docker/dev.dockerfile"

CONTEXT="$(dirname "${BASH_SOURCE[0]}")"

# # Cache all files that required to be downloaded
# pushd . \
# && cd docker/installers  \
# && grep -hr wget install_dependency.sh | while IFS= read -r line; do eval "$line" || true; done \
# && popd 


# Fail on first error.
set -e
docker build -t ${REPO_WITH_DEFAULT_TAG} \
-t ${REPO_WITH_LATEST_TAG} \
-f ${DOCKERFILE} ${CONTEXT}

echo "Built new image ${REPO_WITH_DEFAULT_TAG}"

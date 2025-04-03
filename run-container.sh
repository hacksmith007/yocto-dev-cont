#!/bin/bash

# Build the Docker image
docker build -t yocto-dev-rahul -f .devcontainer/Dockerfile .

# Run the container
docker run -it --rm \
    -v ~/yocto/yocto-sources:/workspace/yocto-sources \
    -v ~/yocto/yocto-build:/workspace/yocto-build \
    -v $(pwd):/workspace \
    -w /workspace \
    --name yocto-dev-rahul yocto-dev-rahul

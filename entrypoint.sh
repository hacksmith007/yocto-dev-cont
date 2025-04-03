#!/bin/bash
set -e  # Exit on any error

# Ensure mount is ready
while [ ! -d "/workspace/yocto-sources" ]; do
    echo "Waiting for /workspace/yocto-sources to be mounted..."
    sleep 2
done

# Clone only if not already cloned
if [ ! -d "/workspace/yocto-sources/.git" ]; then
    echo "Cloning Kirkstone Poky repository..."
    git clone -b kirkstone https://git.yoctoproject.org/poky.git /workspace/yocto-sources
else
    echo "Yocto repository already exists. Skipping clone."
fi

exec "$@"  # Run the container's main process (VS Code)
#!/bin/bash
set -ex  # Exit on any error

# Ensure mount is ready
while [ ! -d "/workspace/yocto-sources" ]; do
    echo "Waiting for /workspace/yocto-sources to be mounted..."
    sleep 2
done

# Clone only if not already cloned
if [ ! -d "/workspace/yocto-sources/.git" ]; then
    echo "Cloning Kirkstone Poky repository..."
    echo 'export GIT_DISCOVERY_ACROSS_FILESYSTEM=1' >> ~/.bashrc
    echo "alias ysrc='cd /workspace/yocto-sources'" >> ~/.bashrc
    echo "Sourcing bashrc"
    git config --global user.email "rahulranjan1618@outlook.com"
    git config --global user.name "Rahul Ranjan"
    if ! git clone -b main git@github.com:hacksmith007/yocto-project.git /workspace/yocto-sources; then
        echo "Git clone failed, but continuing..."
    fi
    cd /workspace/yocto-sources && true
    echo "Cloning submodules..."
    git submodule update --init --recursive
    cd /workspace/yocto-sources/poky
    echo "Sourcing poky environment and making build directory to yocto-build"
    echo 'alias ybld="source /workspace/yocto-sources/poky/oe-init-build-env /workspace/yocto-sources/build"' >> ~/.bashrc
    source ~/.bashrc

else
    echo "Yocto repository already exists. Skipping clone."
fi

exec "$@"  # Run the container's main process (VS Code)
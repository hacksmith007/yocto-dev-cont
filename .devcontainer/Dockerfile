FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install Yocto dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python3 \
    python3-pip \
    python3-pexpect \
    gawk \
    wget \
    diffstat \
    unzip \
    texinfo \
    gcc-multilib \
    socat \
    libsdl1.2-dev \
    xterm \
    chrpath \
    cpio \
    file \
    lz4 \
    xz-utils \
    vim \
    net-tools \
    zstd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install OpenSSH client
RUN apt-get update && apt-get install -y --no-install-recommends openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install and configure locales
RUN apt-get update && apt-get install -y --no-install-recommends locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY setup_env /usr/local/bin/setup_env
COPY git_mstatus /usr/local/bin/git_mstatus
COPY git_mcheckout /usr/local/bin/git_mcheckout
RUN chmod +x /usr/local/bin/setup_env /usr/local/bin/git_mstatus /usr/local/bin/git_mcheckout
ENTRYPOINT ["/usr/local/bin/setup_env"]
# Switch to non-root user
USER $USERNAME



# Use Ubuntu 22.04 LTS (industry standard)
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install LLVM, clangd, and essential build tools
RUN apt-get update && apt-get install -y \
    llvm \
    clangd \
    clang \
    clang-format \
    clang-tidy \
    cmake \
    build-essential \
    gdb \
    git \
    wget \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER vscode

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

# COPY install-large-deps.sh /install-large-deps.sh
# RUN chmod +x /install-large-deps.sh

# RUN --mount=type=bind,source=/build-cache,target=/build-cache \
#     CACHE_DIR=/build-cache INSTALL_DIR=/opt /install-large-deps.sh

# ENV PATH="/opt/llvm/bin:${PATH}"
# ENV LD_LIBRARY_PATH="/opt/llvm/lib:${LD_LIBRARY_PATH}"

# Create a non-root user
RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER vscode

#!/bin/bash
set -e

CACHE_DIR="${CACHE_DIR:-/build-cache}"
INSTALL_DIR="${INSTALL_DIR:-/opt}"

log() {
    echo "[DEPS] $*"
}

install_if_cached() {
    local name="$1"
    local cache_file="$2"
    local download_url="$3"
    local install_cmd="$4"
    
    if [ -f "${CACHE_DIR}/${cache_file}" ]; then
        log "Using cached ${name} from ${CACHE_DIR}/${cache_file}"
        eval "$install_cmd ${CACHE_DIR}/${cache_file}"
    else
        log "Downloading ${name}..."
        local tmp_file="/tmp/${cache_file}"
        wget -O "${tmp_file}" "${download_url}"
        
        log "Installing ${name}..."
        eval "$install_cmd ${tmp_file}"
        
        # Cache for next build
        mkdir -p "${CACHE_DIR}"
        cp "${tmp_file}" "${CACHE_DIR}/" 2>/dev/null || log "Warning: Could not cache ${name}"
        rm -f "${tmp_file}"
    fi
}

# Install LLVM
LLVM_VERSION="17.0.6"
LLVM_ARCHIVE="clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-22.04.tar.xz"
install_if_cached \
    "LLVM ${LLVM_VERSION}" \
    "${LLVM_ARCHIVE}" \
    "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/${LLVM_ARCHIVE}" \
    "tar -xf {} -C ${INSTALL_DIR}"

ln -sf "${INSTALL_DIR}/clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-22.04" "${INSTALL_DIR}/llvm"

# Add more dependencies as needed
# install_if_cached "Node.js" "node-v20.tar.gz" "https://..." "tar -xf {} -C ${INSTALL_DIR}"

log "All dependencies installed!"
#!/bin/bash

set -euo pipefail

# ----------------------------
# Configuration
GITHUB_USER="hosseinit1988"
GITHUB_REPO="ITunnel"
BRANCH="main"
# ----------------------------

# Check for wget or curl
if command -v wget >/dev/null 2>&1; then
    DL_CMD="wget -qO utunnel_manager"
elif command -v curl >/dev/null 2>&1; then
    DL_CMD="curl -sSL -o utunnel_manager"
else
    echo "Error: Neither wget nor curl is installed."
    exit 1
fi

# Determine CPU architecture
ARCH=$(uname -m)

# Map architecture to filename
case "$ARCH" in
    "x86_64")
        FILENAME="utunnel_manager_amd64"
        ;;
    "aarch64" | "arm64")
        FILENAME="utunnel_manager_arm64"
        ;;
    "i386" | "i686")
        FILENAME="utunnel_manager_386"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Build the download URL
URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$BRANCH/$FILENAME"

# Download
echo "Downloading utunnel_manager for $ARCH from:"
echo "$URL"
if ! $DL_CMD "$URL"; then
    echo "Download failed. Please check your internet connection or the file URL."
    exit 1
fi

# Make it executable
chmod +x utunnel_manager

# Run the manager
echo "Starting utunnel_manager..."
./utunnel_manager

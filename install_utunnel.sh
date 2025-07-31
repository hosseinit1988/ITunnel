#!/bin/bash

# Determine CPU architecture
ARCH=$(uname -m)

# Map architecture to download URL
case $ARCH in
    "x86_64")
        URL="https://raw.githubusercontent.com/aliamg1356/utunnel/refs/heads/main/utunnel_manager_amd64"
        ;;
    "aarch64" | "arm64")
        URL="https://raw.githubusercontent.com/aliamg1356/utunnel/refs/heads/main/utunnel_manager_arm64"
        ;;
    "i386" | "i686")
        URL="https://raw.githubusercontent.com/aliamg1356/utunnel/refs/heads/main/utunnel_manager_386"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Download the appropriate version
echo "Downloading utunnel_manager for $ARCH..."
wget -O utunnel_manager $URL || curl -o utunnel_manager $URL

if [ ! -f "utunnel_manager" ]; then
    echo "Failed to download utunnel_manager"
    exit 1
fi

# Make it executable
chmod +x utunnel_manager

# Run the manager
echo "Starting utunnel_manager..."
./utunnel_manager
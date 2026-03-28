#!/bin/bash
# Setup script for Jekyll blog dev + Raspberry Pi 5 Netflix DRM fix
# Run with: bash setup.sh

set -e

echo "=== Setup Script ==="
echo ""

# Detect if running on Raspberry Pi
IS_RASPI=false
if grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
    IS_RASPI=true
    echo "✓ Raspberry Pi detected"
else
    echo "✓ Not a Raspberry Pi (skipping DRM fix)"
fi
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run with sudo: bash setup.sh${NC}"
    exit 1
fi

# Update system
echo "→ Updating system packages..."
apt update
apt full-upgrade -y
echo ""

# Install build essentials
echo "→ Installing build essentials..."
apt install -y build-essential
echo ""

# Install Jekyll dependencies
echo "→ Installing Ruby and Jekyll..."
apt install -y ruby-full
gem install jekyll bundler --no-document
echo ""

# Install Node.js (optional, for some plugins)
echo "→ Installing Node.js..."
apt install -y nodejs npm
echo ""

# Raspberry Pi 5 Netflix DRM fix
if [ "$IS_RASPI" = true ]; then
    echo "→ Setting up Netflix DRM (Widevine)..."
    apt install -y libwidevinecdm0
    echo ""
    
    echo "→ Enabling DRM/KMS..."
    # Add drmmode=1 to cmdline.txt for Pi 5
    if [ -f /boot/firmware/cmdline.txt ]; then
        CMDLINE_FILE="/boot/firmware/cmdline.txt"
    elif [ -f /boot/cmdline.txt ]; then
        CMDLINE_FILE="/boot/cmdline.txt"
    else
        CMDLINE_FILE=""
    fi
    
    if [ -n "$CMDLINE_FILE" ]; then
        if ! grep -q "drmmode=1" "$CMDLINE_FILE" 2>/dev/null; then
            echo "drmmode=1" >> "$CMDLINE_FILE"
            echo "  Added drmmode=1 to $CMDLINE_FILE"
        else
            echo "  drmmode=1 already present"
        fi
    else
        echo "  Warning: Could not find cmdline.txt"
    fi
    echo ""
    
    echo "→ Reinstalling Chromium (ensures DRM support)..."
    apt install -y --reinstall chromium-browser
    echo ""
fi

echo "=== Setup Complete ==="
echo ""
echo "To run your Jekyll blog locally:"
echo "  cd ~/Desktop/honghaptang.github.io"
echo "  jekyll serve"
echo ""
echo "Then open: http://localhost:4000"
echo ""

if [ "$IS_RASPI" = true ]; then
    echo "⚠ REBOOT REQUIRED for Netflix DRM to work!"
    echo "  Run: sudo reboot"
    echo ""
    echo "After reboot, use Chromium for Netflix:"
    echo "  https://www.netflix.com"
fi

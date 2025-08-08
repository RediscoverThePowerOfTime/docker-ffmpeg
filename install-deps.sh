#!/bin/bash
# install-deps.sh - Automatic dependency installation for Railway

echo "Installing ImageMagick and dependencies..."

# Update package list
apt-get update

# Install ImageMagick and bc calculator
apt-get install -y imagemagick bc

# Verify installation
echo "Verifying ImageMagick installation..."
convert -version

echo "Verifying bc installation..."
echo "2 + 2" | bc

echo "Installation complete!"

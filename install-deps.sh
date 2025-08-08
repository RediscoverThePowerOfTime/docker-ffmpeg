#!/bin/bash

# install-deps.sh - Verify ImageMagick and dependencies installation

echo "=== Verifying Time Rediscovered video processing dependencies ==="

# Verify FFmpeg installation
echo "Checking FFmpeg..."
if command -v ffmpeg &> /dev/null; then
    echo "✅ FFmpeg is installed: $(ffmpeg -version | head -n 1)"
else
    echo "❌ FFmpeg not found!"
    exit 1
fi

# Verify ImageMagick installation
echo "Checking ImageMagick..."
if command -v convert &> /dev/null; then
    echo "✅ ImageMagick is installed: $(convert -version | head -n 1)"
else
    echo "❌ ImageMagick not found!"
    exit 1
fi

# Verify bc calculator installation  
echo "Checking bc calculator..."
if command -v bc &> /dev/null; then
    echo "✅ bc calculator is installed"
    echo "   Test calculation: 2 + 2 = $(echo '2 + 2' | bc)"
else
    echo "❌ bc calculator not found!"
    exit 1
fi

# Test ImageMagick sharpness detection functionality
echo "Testing ImageMagick sharpness detection..."
convert -size 100x100 xc:white /tmp/test_white.png
convert -size 100x100 xc:black /tmp/test_black.png

white_sharpness=$(convert /tmp/test_white.png -colorspace Gray -define convolve:scale='!' -morphology Convolve Laplacian:0 -format "%[standard-deviation]" info: 2>/dev/null)
black_sharpness=$(convert /tmp/test_black.png -colorspace Gray -define convolve:scale='!' -morphology Convolve Laplacian:0 -format "%[standard-deviation]" info: 2>/dev/null)

echo "   White image sharpness: $white_sharpness"
echo "   Black image sharpness: $black_sharpness"

# Cleanup test files
rm -f /tmp/test_white.png /tmp/test_black.png

if [ -n "$white_sharpness" ] && [ -n "$black_sharpness" ]; then
    echo "✅ ImageMagick sharpness detection is working!"
else
    echo "❌ ImageMagick sharpness detection failed!"
    exit 1
fi

echo "=== All dependencies verified successfully! ==="
echo "🎬 Ready for intelligent video processing with sharpness detection!"

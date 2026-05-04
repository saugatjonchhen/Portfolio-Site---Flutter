#!/bin/bash

# Portfolio Image Optimization Script
# This script helps convert project images to WebP for faster loading on the web.
# Requirement: cwebp (part of libwebp)

echo "🚀 Starting image optimization..."

# Create optimized directory if it doesn't exist
mkdir -p assets/images/optimized

# Find all png/jpg files in assets/images and convert them
for f in assets/images/*.{png,jpg,jpeg}; do
    [ -e "$f" ] || continue
    filename=$(basename "$f")
    extension="${filename##*.}"
    name="${filename%.*}"
    
    echo "Processing $filename..."
    
    # Using cwebp with 75% quality for a good balance of size and quality
    if command -v cwebp &> /dev/null; then
        cwebp -q 75 "$f" -o "assets/images/optimized/${name}.webp"
    else
        echo "⚠️  cwebp not found. Please install it with: brew install webp"
        exit 1
    fi
done

echo "✅ Optimization complete! Files are in assets/images/optimized/"

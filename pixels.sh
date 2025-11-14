#!/bin/bash

# Directory to process (current directory by default)
DIRECTORY="."

for img in "$DIRECTORY"/*.{jpg,jpeg,png,gif,bmp}; do
  # Check if the file exists (to avoid errors if no matching files)
  if [[ -f "$img" ]]; then
    echo "Processing $img..."

    # Generate output filename (change extension to .bmp)
    output="${img%.*}_4bit.bmp"

    # Resize to a height of 200 pixels (keeping aspect ratio) and convert to 4-bit BMP
    convert "$img" -resize x200 -depth 4 -type Palette BMP3:"$output"

    echo "Saved as $output"
  fi
done

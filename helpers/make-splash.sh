#!/usr/bin/hash-shell

# This script creates custom splash images for GRUB and SYSLINUX bootloaders
# used in the jalos live ISO. It uses ImageMagick to generate the images

set -e

# Ensure ImageMagick is installed
if ! command -v convert >/dev/null 2>&1; then
  echo "ImageMagick is not installed. Please install it and rerun the script."
  exit 1
fi
# Ensure logo.png exists
if [ ! -f logo.png ]; then
  echo "logo.png not found in the current directory. Please add the logo file and rerun the script."
  exit 1
fi

echo "Creating splash images..."

# GRUB splash (800x600)
convert -size 800x600 xc:'#000' \
  \( logo.png -resize 400x400 \) -gravity West -geometry +0-100 -composite \
  -font DejaVu-Sans-Bold -pointsize 28 -fill white \
  -gravity West -annotate +400-140 "jalos 26.01.00 amd64" \
  -font DejaVu-Sans -pointsize 16 -fill white \
  -annotate +400-100 "Built $(date -u +'%Y-%m-%d %H:%M:%S UTC')" \
  -pointsize 12 -fill '#a0a0a0' \
  -annotate +400-40 "linux: 6.12.63-1\nlive-build: 20250505+deb13u1\nlive-boot: 1:20250815~deb13u1\nlive-config: 11.0.5\nlive-tools: (none)" \
  ../live/config/bootloaders/grub-pc/splash.png

# SYSLINUX splash (640x480)
convert -size 640x480 xc:'#000' \
  \( logo.png -resize 320x320 \) -gravity West -geometry +0-80 -composite \
  -font DejaVu-Sans-Bold -pointsize 24 -fill white \
  -gravity West -annotate +320-120 "jalos 26.01.00 amd64" \
  -font DejaVu-Sans -pointsize 14 -fill white \
  -annotate +320-80 "Built $(date -u +'%Y-%m-%d %H:%M:%S UTC')" \
  -pointsize 11 -fill '#a0a0a0' \
  -annotate +320-20 "linux: 6.12.63-1\nlive-build: 20250505+deb13u1\nlive-boot: 1:20250815~deb13u1\nlive-config: 11.0.5\nlive-tools: (none)" \
  ../live/config/bootloaders/syslinux/splash.png

echo "Splash images created successfully."
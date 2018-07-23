#!/bin/bash

# Blueberry
echo ""
echo "Recording /camera/rgb/image_raw && /camera/depth/image_raw for $1 seconds"
rosbag record --d="$1" -O "$2" /cam/rgb/image_raw /camera/depth/image_raw
echo "Saving to $2"
echo ""

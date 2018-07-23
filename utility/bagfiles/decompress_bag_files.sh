#!/bin/bash

output_dir="."

if [[ $1 != '' ]]; then
  output_dir="$1"
  echo $output_dir
fi

# Launch from directory containing bag files
rosbag decompress --output-dir $output_dir *.bag

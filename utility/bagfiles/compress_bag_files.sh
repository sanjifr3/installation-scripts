#!/bin/bash
DATE=`date +%Y-%m-%d`
mkdir -p ~/bagfiles/$DATE/compressed
cd ~/bagfiles/$DATE
rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

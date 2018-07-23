#!/bin/bash

# rosbag record for a single frame on kinect (add more topics as necessary)
rosbag record /camera/depth/image_raw /camera/rgb/image_raw -- limit=1



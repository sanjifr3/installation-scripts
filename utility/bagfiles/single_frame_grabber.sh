#!/bin/bash

NAME=$1
NUM_IMAGES=10
DATE=`date +%Y-%m-%d`
POSITION=NULL
DIRECTION=N
RGB_TOPIC="/cam/rgb/image_raw"
DEPTH_TOPIC="/camera/depth/image_raw"

if [[ $1 == '' ]]; then
  echo "No name given to bash script"
  exit 1
fi

mkdir -p ~/bagfiles/$DATE
cd ~/bagfiles/$DATE

rosrun image_view image_saver image:=${RGB_TOPIC} _save_all_image:=false _filename_format:=${NAME}_${POSITION}_${DIRECTION}_%0.3i.jpg __name:=rgb_im_saver &
rosrun image_view image_saver image:=${DEPTH_TOPIC} _save_all_image:=false _encoding:=16UC1 _filename_format:=${NAME}_${POSITION}_${DIRECTION}_%0.3i.tiff __name:=depth_im_saver &
sleep 4s

for((i=0; i<${NUM_IMAGES}; i++))
do
  if [[ ${i} -lt 10 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_00${i}
  elif [[ ${i} -lt 100 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_0${i}
  else 
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_${i}
  fi
  echo ''
  
  rosservice call /rgb_im_saver/save
  rosservice call /depth_im_saver/save
  
  if [[ n -eq 0 ]]; then
    read  -n 1 -p "Press any key to continue"
  fi
done

#rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

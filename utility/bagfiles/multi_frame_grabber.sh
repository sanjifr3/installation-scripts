#!/bin/bash

NAME=$1
NUM_VIDEOS=30
DURATION=0.75
DATE=`date +%Y-%m-%d`
POSITION=NULL
DIRECTION=N
RGB_TOPIC="/cam/rgb/image_raw"
DEPTH_TOPIC="/camera/depth/image_raw"
INDEX=$2

if [[ $1 == '' ]]; then
  echo "No name given to bash script"
  exit 1
fi

if [[ $2 == '' ]]; then
  echo "No index given to bash script"
  exit 1
fi

mkdir -p ~/bagfiles/$DATE
cd ~/bagfiles/$DATE

for((i=0; i<${NUM_VIDEOS}; i++))
do
  if [[ ${i} -lt 10 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_${INDEX}00${i}
  elif [[ ${i} -lt 100 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_${INDEX}0${i}
  else 
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_${INDEX}${i}
  fi
  echo ''
  
  read  -n 1 -p "Press any key to continue"
  echo "Recording for ${DURATION} seconds"
  rosbag record --d=$DURATION -O $FILENAME $RGB_TOPIC $DEPTH_TOPIC
  echo "Bag saved to ~/bagfiles/${DATE}/${FILENAME}"
  echo ''
done

#rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

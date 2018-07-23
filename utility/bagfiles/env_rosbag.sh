#!/bin/bash

#kill all child processes
#trap ctrl_c INT
#function ctrl_c() {
#  rosnode kill -a && 
#  kill % &&
#  sleep 3
#  kill % &&
#  sleep 3
#  kill % &&
#  sleep 3
#  kill %
#  pkill -P $$ --signal 9
#  pkill ros
#  exit
#}

DURATION=0.75
DATE=`date +%Y-%m-%d`
NAME=MCENV
POSITION=NULL
DIRECTION=N
STARTING_INDX=50
RGB_TOPIC="/cam/rgb/image_raw"
DEPTH_TOPIC="/camera/depth/image_raw"
NUM_VIDEOS=50
VIDEOS_PER_LOCATION=1

#if [[ $1 == '' ]]; then
 # echo "No name given to bash script"
 # exit 1
#fi

mkdir -p ~/bagfiles/$DATE
cd ~/bagfiles/$DATE

for((i=0; i<${NUM_VIDEOS}; i++))
do
  j=$((${i}+${STARTING_INDX}))   
  if [[ ${j} -lt 10 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_00${j}
  elif [[ ${j} -lt 100 ]]; then
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_0${j}
  else 
    FILENAME=${NAME}_${POSITION}_${DIRECTION}_${j}
  fi
  echo ''
  
  n=$((i%VIDEOS_PER_LOCATION))
  
  if [[ n -eq 0 ]]; then
    read  -n 1 -p "Press any key to continue"
  fi
    
  echo "Recording for ${DURATION} seconds"
  rosbag record --d=$DURATION -O $FILENAME $RGB_TOPIC $DEPTH_TOPIC
  echo "Bag saved to ~/bagfiles/${DATE}/${FILENAME}"
  sleep 1s
  echo ''
done

#rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

wait

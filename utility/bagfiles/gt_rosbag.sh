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

DURATION=5
DATE=`date +%Y-%m-%d`
NAME=$1
POSITION=$2
RGB_TOPIC="/cam/rgb/image_raw"
DEPTH_TOPIC="/camera/depth/image_raw"

if [[ $1 == '' ]]; then
  echo "No name given to bash script"
  exit 1
fi

positions_list=(Standing
                Sitting
)

directions_list=(F
                 FR1
                 FR2
                 R
                 BR2
                 BR1
                 B
                 BL1
                 BL2
                 L
                 FL2
                 FL1
)
#roscore &
#roslaunch blueberry_2dnav rgb_camera.launch &
#roslaunch openni2_launch openni2.launch &

#sleep 10
#rqt_image_view &

mkdir -p ~/bagfiles/$DATE
cd ~/bagfiles/$DATE
for((i=0; i <${#positions_list[@]}; i++))
do
  for((j=0; j<${#directions_list[@]}; j++))
  do
    FILENAME=${NAME}_${positions_list[i]}_${directions_list[j]}
    echo ''
    read  -n 1 -p "Press any key to continue"
    echo "Recording for ${DURATION} seconds"
    rosbag record --d=$DURATION -O $FILENAME $RGB_TOPIC $DEPTH_TOPIC
    echo "Bag saved to ~/bagfiles/${DATE}/${FILENAME}"
    echo ''
  done
done  

#rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

wait

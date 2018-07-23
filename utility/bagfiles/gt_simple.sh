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

#Half	Thirds	Quarters
#1.5			
#			2
#		2.1666666667	
#	2.5		2.5
#		2.8333333333	
#			3
#3.5			
			
			
#	locations	locations	locations
#	2	1.8333333333	1.75
#	3	2.5	2.25
#		3.1666666667	2.75
#			3.25

distances_list=(175
                225
                275
                325
)

positions_list=(Standing
                Sitting
)

directions_list=(F
                 #FR1
                 #FR2
                 R
                 #BR2
                 #BR1
                 B
                 #BL1
                 #BL2
                 L
                 #FL2
                 #FL1
)
#roscore &
#roslaunch blueberry_2dnav rgb_camera.launch &
#roslaunch openni2_launch openni2.launch &

#sleep 10
#rqt_image_view &

mkdir -p ~/bagfiles/$DATE
cd ~/bagfiles/$DATE
for((k=0; k<${#distances_list[@]}; k++))
do
  for((i=0; i<${#positions_list[@]}; i++))
  do
    for((j=0; j<${#directions_list[@]}; j++))
    do
      FILENAME=${NAME}_${positions_list[i]}_${directions_list[j]}_${distances_list[k]}
      echo ''
      read  -n 1 -p "Press any key to continue"
      echo "Recording for ${DURATION} seconds"
      rosbag record --d=$DURATION -O $FILENAME $RGB_TOPIC $DEPTH_TOPIC
      echo "Bag saved to ~/bagfiles/${DATE}/${FILENAME}"
      echo ''
    done
  done
done

#rosbag compress --output-dir=compressed *.bag
cd ~/blueberry/scripts/bagfiles/

wait

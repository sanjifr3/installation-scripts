#!/bin/bash
trap ctrl_c INT
function ctrl_c() {
  pkill -P $$ --signal 9
	pkill ros
  exit
}

echo $HOME
export DISPLAY=:0
gedit &
#roslaunch blueberry_2dnav alpha.launch &
#sleep 25s
#roslaunch tile_search lrps.launch &
#roslaunch blueberry_2dnav move_base.launch

wait

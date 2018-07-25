#!/bin/bash


#kill all child processes
trap ctrl_c INT
function ctrl_c() {
  pkill -P $$ --signal 9
	pkill ros
  exit
}

# Define a timestamp function
timestamp() {
  date +"%T"
}

timestamp

#roscore > $HOME/scripts/logs/roscore_log.txt 2>&1 &

#computer_list=(drrobot1@blueberry1
#              drrobot2@blueberry2
#							 #sanjif-raj@sanjif-pc
#               )

# roslaunch blueberry_2dnav master.launch > $HOME/scripts/logs/master_launch_log.txt &

ssh -o StrictHostKeyChecking=no -l sanjif sanjif@192.168.0.136 "bash -s"  < \
./alpha_launch.sh &

#ssh -o StrictHostKeyChecking=no -l sanjif drrobot2@blueberry2 "bash -s" < \
#./beta_launch.sh &


#
	#			if [ ${id} == my_computer ]
		#		then
		#			./test_remote.sh ${tasks[tasks_assigned]} >> \
		#      $HOME/.ProjectBlueKangaroo/Simulator/test_cases_found/logs/computer${id}_instance$j \
		#      2>&1 &
		#		else
		#			ssh -o StrictHostKeyChecking=no -l liondavi $id "bash -s" < \
		#				  ./test_remote.sh ${tasks[tasks_assigned]} >> \
		#          $HOME/.ProjectBlueKangaroo/Simulator/test_cases_found/logs/computer${id}_instance$j \
		#          2>&1 &
		#		fi

#sfor((i=0; i<${#computer_list[@]}; i++))
#do
#	computer=${computer_list[i]}
#  ssh -o StrictHostKeyChecking=no -l sanjif $computer "bash -s" < \
#  ./launch.sh   #>> $HOME/logs/${computer_list[i]} 2>&1 &
#done


# wait for all programs to finish
wait

timestamp

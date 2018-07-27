#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
CHANNELS=${RESPEAKER_CHANNELS:-6}

roscd rplidar
cd scripts
./create_udev_rules.sh

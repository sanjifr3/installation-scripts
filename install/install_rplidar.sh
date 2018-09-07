#!/bin/bash

roscd rplidar
cd scripts
./create_udev_rules.sh
sudo systemctl restart udev

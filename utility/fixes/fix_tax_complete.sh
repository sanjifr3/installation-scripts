#!/bin/bash
# Fix when tab complete stops working

# Need to sudo run

# To run : sudo ./fixTabComplete.sh
sudo umount $HOME/.gvfs 
#sleep 3s # Enter password before time is up
rm -rf .gvfs/

#!/bin/bash
# Uninstalls torch from system

sudo rm -rf ~/torch &&
sudo rm -rf ~/.cache/luarocks &&

echo Remove line related to torch in both of the opened files
gedit ~/.profile &
gedit ~/.bashrc

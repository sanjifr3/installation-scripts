#!/bin/bash
# Command to fix .cache/pip ownership

sudo chown -R $USER:$USER ~/.cache &&
sudo usermod -a -G staff $USER

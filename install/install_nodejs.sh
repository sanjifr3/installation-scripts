#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}

cd $DIR
sudo apt-get install -y curl python-software-properties
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get install -y nodejs
node -v 

#!/bin/bash
sudo apt-get install -y awscli &&
mkdir -p ~/.aws/ &&
cp ~/mia-main/src/mia_tts/credentials/* ~/.aws

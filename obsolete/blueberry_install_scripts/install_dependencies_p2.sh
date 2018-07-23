#!/bin/bash
## Install amazon speech to text
# Add aws credentials for Polly
sudo apt-get install -y awscli &&
mkdir -p ~/.aws/ &&
cp ~/blueberry/src/blueberry_tts/credentials/* ~/.aws

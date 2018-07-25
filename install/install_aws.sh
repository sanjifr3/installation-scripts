#!/bin/bash
# Copy credentials into polly/credentials
# Sample credentials file = polly/credentials/.credentials

sudo apt-get install -y awscli &&
mkdir -p ~/.aws/ &&
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cp $SCRIPTPATH/polly/credentials/* ~/.aws



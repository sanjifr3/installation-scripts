#!/bin/bash
# Create a new ssh-key
ssh-keygen -t rsa -b 4096 -C "r.sanjif@gmail.com"
# Press enter x3

# Start an ssh background process
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Copy public ssh key to clipboard
xclip -sel clip < ~/.ssh/id_rsa.pub

# Go to github > settings > ssh and gpg keys and create
# a new key, and paste

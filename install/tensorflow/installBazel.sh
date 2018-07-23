#!/bin/bash
# NVIDIA Jetson TX2
# TensorFlow Installation
# Install Bazel
# Version 0.5.2 - v0.5.3 apparently has issues
# We use the release distribution so that we don't have to build protobuf
#
DIR=${PROGRAM_PATH:-$HOME/programs}
VERSION=${BAZEL_VERSION:-0.10.1}

cd $DIR
wget --no-check-certificate https://github.com/bazelbuild/bazel/releases/download/$VERSION/bazel-${VERSION}-dist.zip
unzip bazel-${VERSION}-dist.zip -d bazel-${VERSION}-dist
sudo chmod -R ug+rwx bazel-${VERSION}-dist
cd bazel-${VERSION}-dist
./compile.sh 
sudo cp output/bazel /usr/local/bin
rm ../bazel-${VERSION}-dist.zip

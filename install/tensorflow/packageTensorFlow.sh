#!/bin/bash
# NVIDIA Jetson TX2
DIR=${PROGRAM_PATH:-$HOME/programs}

cd $DIR/tensorflow
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
mv /tmp/tensorflow_pkg/tensorflow-*.whl $DIR


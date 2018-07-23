#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
VERSION=${OPENBLAS_VERSION:-0.2.20}

cd $DIR
git clone https://github.com/xianyi/OpenBLAS.git

cd OpenBlas
git checkout v$VERSION

make clean
make DYNAMIC_ARCH=1
sudo make DYNAMIC_ARCH=1 install

#To install the library, you can run "make PREFIX=/path/to/your/installation install"

# Set alternative to our freshly-built binaries
sudo update-alternatives --add /usr/lib/openblas-base/libblas.so.3 libblas.so.3 /opt/OpenBLAS/lib/libopenblas.so.0 41 \
                         --slave /usr/lib/liblapack.so.3 liblapack.so.3 /opt/OpenBLAS/lib/libopenblas.so.0
   
# Revert back to APT-provided BLAS implementation order
#sudo update-alternatives --remove libblas.so.3 /opt/OpenBLAS/lib/libopenblas.so.0   

#make[1]: Entering directory '/home/sanjif/programs/OpenBLAS'
#Generating openblas_config.h in /opt/OpenBLAS/include
#Generating f77blas.h in /opt/OpenBLAS/include
#Generating cblas.h in /opt/OpenBLAS/include
#Copying LAPACKE header files to /opt/OpenBLAS/include
#Copying the static library to /opt/OpenBLAS/lib
#Copying the shared library to /opt/OpenBLAS/lib
#Generating openblas.pc in /opt/OpenBLAS/lib/pkgconfig
#Generating OpenBLASConfig.cmake in /opt/OpenBLAS/lib/cmake/openblas
#Generating OpenBLASConfigVersion.cmake in /opt/OpenBLAS/lib/cmake/openblas


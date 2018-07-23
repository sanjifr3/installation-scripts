#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}

source ~/.bashrc
sudo apt-get update

echo "Installing Torch Libraries..."

cd $DIR/torch

git clone https://github.com/Yonaba/Moses.git
git clone https://github.com/nicholas-leonard/torchx.git
git clone https://github.com/Element-Research/dpnn.git
git clone https://github.com/torch/cunn.git

# Backup
cp install/bin/luajit install/bin/luajit.back
cp install/bin/luarocks install/bin/luarocks.back
cp install/bin/luarocks-admin install/bin/luarocks-admin.back

luarocks make Moses/rockspec/moses-1.6.0-1.rockspec
luarocks make torchx/torchx-scm-1.rockspec
luarocks make dpnn/rocks/dpnn-scm-1.rockspec

cd cunn
luaroacks make rocks/cunn-scm1.rockspec
cd ..

#sudo rm -rf ~/.cache/luarocks &&
luarocks install image
#luarocks install list

# Fix ~ renaming issue
mv install/bin/luajit~ install/bin/luajit
mv install/bin/luarocks~ install/bin/luarocks
mv install/bin/luarocks-admin~ install/bin/luarocks-admin

for NAME in csvigo torch dpnn optim nn torchx optnet tds; do luarocks install $NAME; done

# If this fails because of missing luarocks
# go to $DIR/torch/install/bin
# and check if luarocks and luajit exist with '~' in their title
# just remove '~' to make them work

cp install/bin/luajit.back install/bin/luajit
cp install/bin/luarocks.back install/bin/luarocks
cp install/bin/luarocks-admin.back install/bin/luarocks-admin

source ~/.bashrc
for NAME in csvigo torch dpnn optim nn torchx optnet tds; do luarocks install $NAME; done



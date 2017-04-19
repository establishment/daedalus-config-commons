#!/bin/sh
#set -x

apt-get install gcc-c++ openssl-devel
cwd=$(pwd)
cd /usr/local/src
wget http://nodejs.org/dist/v7.4.0/node-v7.4.0.tar.gz
tar zxvf node-v7.4.0.tar.gz
cd node-v7.4.0
./configure
make
make install
which node
cd ${cwd}

#!/bin/sh
#set -x

apt-get install gcc-c++ openssl-devel
cwd=$(pwd)
cd /usr/local/src
wget http://nodejs.org/dist/v5.8.0/node-v5.8.0.tar.gz
tar zxvf node-v5.8.0.tar.gz
cd node-v5.8.0
./configure
make
make install
which node
cd ${cwd}
#!/usr/bin/env bash

# Install everything
daedalus apt install g++
daedalus apt install python3
daedalus apt install python3-setuptools
daedalus apt install python3-dev
daedalus apt install make
daedalus apt install redis-tools
daedalus apt install postgresql-server-dev-all
daedalus apt install libjpeg-dev
daedalus apt install libffi-dev
daedalus apt install libssl-dev
daedalus apt install libpq-dev
daedalus apt install build-essential
daedalus apt install libpython-all-dev
daedalus apt install python-dev
daedalus apt install python3-dev
daedalus apt install python3.5-dev
easy_install3 pip
pip3 install cffi

apt-get autoremove -y

pip3 install --upgrade -r ${DAEDALUS_CONFIG_MODULE_PATH}/res/requirements.txt
pip3 install --upgrade uwsgi
pip3 install Pillow

#!/bin/bash

mkdir -p pid/${DAEDALUS_FULL_MODULE_NAME}
mkdir -p log/${DAEDALUS_FULL_MODULE_NAME}
nohup uwsgi --ini "${DAEDALUS_FULL_STATE_MODULE_PATH}/uwsgi.ini" --pidfile pid/${DAEDALUS_FULL_MODULE_NAME}/uwsgi.pid > log/${DAEDALUS_FULL_MODULE_NAME}/uwsgi.log 2>log/${DAEDALUS_FULL_MODULE_NAME}/uwsgi.log &


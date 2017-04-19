#!/usr/bin/env bash

REDIS_TYPE=${1}

apt-get install -y redis-server

/etc/init.d/redis-server stop

rm /etc/redis/redis.conf > /dev/null 2>&1
cp ${DAEDALUS_CONFIG_MODULE_PATH}/res/${REDIS_TYPE}/redis.conf /etc/redis/redis.conf

/etc/init.d/redis-server start

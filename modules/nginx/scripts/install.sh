#!/usr/bin/env bash

daedalus apt install nginx

mkdir -p /etc/nginx/sites-extensions

rm /etc/nginx/nginx.conf
cp ${DAEDALUS_CONFIG_MODULE_PATH}/res/nginx.conf /etc/nginx/nginx.conf

nginx -s reload


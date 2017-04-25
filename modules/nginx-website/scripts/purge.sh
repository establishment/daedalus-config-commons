#!/usr/bin/env bash

DOMAIN=${1}

rm /etc/nginx/sites-enabled/${DOMAIN} > /dev/null 2>&1

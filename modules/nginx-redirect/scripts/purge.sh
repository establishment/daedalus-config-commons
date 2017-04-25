#!/usr/bin/env bash

PORT=${1}
DOMAIN=${2}

rm /etc/nginx/sites-enabled/${PORT}.${DOMAIN} > /dev/null 2>&1


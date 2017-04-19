#!/usr/bin/env bash

DOMAIN=${1}

rm /etc/nginx/sites-enabled/${DOMAIN} > /dev/null 2>&1
rm /etc/nginx/sites-enabled/http.${DOMAIN} > /dev/null 2>&1
rm /etc/nginx/sites-enabled/http.www.${DOMAIN} > /dev/null 2>&1

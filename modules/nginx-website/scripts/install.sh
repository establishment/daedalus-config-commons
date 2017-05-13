#!/usr/bin/env bash

DOMAIN=${1}
TARGET=${2}
DJANGO_APP=${3}

PORT=${4}
UWSGI_PROCESSES=${5}
UWSGI_THREADS=${6}
UWSGI_BUFFER_THREAD=${7}
UWSGI_SOCKET_QUEUE_SIZE=${8}

mkdir -p "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions"

daedalus template clear
daedalus template set DAEDALUS_PROJECT_PATH "${DAEDALUS_PROJECT_PATH}"
daedalus template set DAEDALUS_FULL_STATE_MODULE_PATH "${DAEDALUS_FULL_STATE_MODULE_PATH}"
daedalus template set DOMAIN "${DOMAIN}"
daedalus template set DJANGO_APP "${DJANGO_APP}"
daedalus template set PORT "${PORT}"
daedalus template set UWSGI_PROCESSES "${UWSGI_PROCESSES}"
daedalus template set UWSGI_THREADS "${UWSGI_THREADS}"
daedalus template set UWSGI_BUFFER_SIZE "${UWSGI_BUFFER_SIZE}"
daedalus template set UWSGI_SOCKET_QUEUE_SIZE "${UWSGI_SOCKET_QUEUE_SIZE}"

daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/website.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/${DOMAIN}"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/uwsgi.ini" "${DAEDALUS_FULL_STATE_MODULE_PATH}/uwsgi.ini"

daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/uwsgi_params" "${DAEDALUS_FULL_STATE_MODULE_PATH}/uwsgi_params"

rm "/etc/nginx/sites-enabled/${DOMAIN}" > /dev/null 2>&1
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/${DOMAIN}" "/etc/nginx/sites-enabled/${DOMAIN}"

mkdir -p "/etc/nginx/sites-extensions"

rm "/etc/nginx/sites-extensions/${DOMAIN}-extension" > /dev/null 2>&1
touch "${DAEDALUS_FULL_STATE_MODULE_PATH}/extension.conf"
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extension.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension"

rm "/etc/nginx/sites-extensions/${DOMAIN}-extension-common" > /dev/null 2>&1
cp "${DAEDALUS_CONFIG_MODULE_PATH}/res/extensions/common.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf"
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension-common"

daedalus nginx link ${DOMAIN} common

if [ "$PORT" = "443" ]; then
    rm "/etc/nginx/sites-extensions/${DOMAIN}-extension-ssl" > /dev/null 2>&1
    daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/extensions/ssl.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/ssl.conf"
    ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/ssl.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension-ssl"

    daedalus nginx link ${DOMAIN} ssl
fi

nginx -s reload

#!/usr/bin/env bash

DOMAIN=${1}
TARGET=${2}

DJANGO_MODULE_NAME=${3}
UWSGI_PROCESSES=${4}
UWSGI_THREADS=${5}
UWSGI_BUFFER_THREAD=${6}
UWSGI_SOCKET_QUEUE_SIZE=${7}

mkdir -p "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions"

daedalus template clear
daedalus template set DAEDALUS_PROJECT_PATH "${DAEDALUS_PROJECT_PATH}"
daedalus template set DAEDALUS_STATE_MODULE_PATH "${DAEDALUS_STATE_MODULE_PATH}"
daedalus template set DOMAIN "${DOMAIN}"
daedalus template set DJANGO_MODULE_NAME "${DJANGO_MODULE_NAME}"
daedalus template set UWSGI_PROCESSES "${UWSGI_PROCESSES}"
daedalus template set UWSGI_THREADS "${UWSGI_THREADS}"
daedalus template set UWSGI_BUFFER_SIZE "${UWSGI_BUFFER_SIZE}"
daedalus template set UWSGI_SOCKET_QUEUE_SIZE "${UWSGI_SOCKET_QUEUE_SIZE}"

daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/${TARGET}/website" "${DAEDALUS_FULL_STATE_MODULE_PATH}/${DOMAIN}"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/uwsgi.ini" "${DAEDALUS_FULL_STATE_MODULE_PATH}/uwsgi.ini"

daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/uwsgi_params" "${DAEDALUS_FULL_STATE_MODULE_PATH}/uwsgi_params"

rm "/etc/nginx/sites-enabled/${DOMAIN}" > /dev/null 2>&1
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/${DOMAIN}" "/etc/nginx/sites-enabled/${DOMAIN}"

mkdir -p "/etc/nginx/sites-extensions"

rm "/etc/nginx/sites-extensions/${DOMAIN}-extension"
touch ${DAEDALUS_STATE_MODULE_PATH}\#${DAEDALUS_MODULE_NAMESPACE}/extension.conf
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extension.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension"

rm "/etc/nginx/sites-extensions/${DOMAIN}-extension-common"
cp "${DAEDALUS_CONFIG_MODULE_PATH}/res/extensions/common.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf"
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension-common"

daedalus nginx link ${DOMAIN} common

if [ "$TARGET" = "live" ]; then
    rm "/etc/nginx/sites-extensions/${DOMAIN}-extension-ssl"
    daedalus template render-to "${DAEDALUS_CONFIG_MODULES_PATH}/res/extensions/ssl.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/ssl.conf"
    ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/ssl.conf" "/etc/nginx/sites-extensions/${DOMAIN}-extension-ssl"

    daedalus nginx link ${DOMAIN} ssl

    rm "/etc/nginx/sites-enabled/http.${DOMAIN}"
    daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/live/http.website" "${DAEDALUS_FULL_STATE_MODULE_PATH}/http.${DOMAIN}"
    ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/http.${DOMAIN}" "/etc/nginx/sites-enabled/http.${DOMAIN}"

    rm "/etc/nginx/sites-enabled/http.www.${DOMAIN}"
    daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/live/http.www.website" "${DAEDALUS_FULL_STATE_MODULE_PATH}/http.www.${DOMAIN}"
    ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/http.www.${DOMAIN}" "/etc/nginx/sites-enabled/http.www.${DOMAIN}"
fi

nginx -s reload

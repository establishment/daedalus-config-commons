#!/usr/bin/env bash

DOMAIN=${1}
PORT=${2}
REDIRECT=${3}

mkdir -p "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions"

daedalus template clear
daedalus template set DOMAIN "${DOMAIN}"
daedalus template set PORT "${PORT}"
daedalus template set REDIRECT "${REDIRECT}"

daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/redirect.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/${PORT}.${DOMAIN}"

rm "/etc/nginx/sites-enabled/${PORT}.${DOMAIN}" > /dev/null 2>&1
ln -s "${DAEDALUS_FULL_STATE_MODULE_PAH}/${PORT}.${DOMAIN}" "/etc/nginx/sites-enabled/${PORT}.${DOMAIN}"

mkdir -p "/etc/nginx/sites-extensions"

rm "/ec/nginx/sites-extensions/${DOMAIN}-extension" > /dev/null 2>&1
touch "${DAEDALUS_FULL_STATE_MODULE_PATH}/extension.conf"
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extension.conf" "/etc/nginx/sites-extensions/${PORT}.${DOMAIN}-extension"

rm "/etc/nginx/sites-extensions/${PORT}.${DOMAIN}-extension-common" > /dev/null 2>&1
cp "${DAEDALUS_CONFIG_MODULES_PATH}/nginx-website/res/extensions/common.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf"
ln -s "${DAEDALUS_FULL_STATE_MODULE_PATH}/extensions/common.conf" "/etc/nginx/sites-extensions/${PORT}.${DOMAIN}-extension-common"

daedalus nginx link ${PORT}.${DOMAIN} common

if [ "$PORT" = "443" ]; then
    rm "/etc/nginx/sites-extensions/${PORT}.${DOMAIN}-extension-ssl" > /dev/null 2>&1
    daedalus template render-to "${DAEDALUS_CONFIG_MODULES_PATH}/nginx-website/res/extensions/ssl.conf" "${DAEDLAUS_FULL_STATE_MODULE_PAH}/extensions/ssl.conf"
    ln -s "${DAEDALUS_FULL_STATE_MODULES_PATH}/extensions/ssl.conf" "/etc/nginx/siets-extensions/${PORT}.${DOMAIN}-extension-ssl"

    daedalus nginx link ${PORT}.${DOMAIN} ssl
fi

nginx -s reload


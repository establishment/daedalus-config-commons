#!/usr/bin/env bash

DOMAIN=${1}
TARGET=${2}
DJANGO_APP=${3}
DJANGO_APP_DATABASE_NAME=${4}

POSTGRES_PASSWORD=${5}

LINODE_API_TOKEN=${6}

EMAIL_SERVER_EMAIL=${7}
EMAIL_USE_TLS=${8}
EMAIL_HOST=${9}
EMAIL_PORT=${10}
EMAIL_HOST_USER=${11}
EMAIL_HOST_PASSWORD=${12}
EMAIL_DEFAULT_FROM_EMAIL=${13}

RECAPTCHA_PRIVATE_KEY=${14}
MOCK_MACHINE_ID=${15}

ACCOUNTS_EMAIL_HOST=${16}
ACCOUNTS_EMAIL_PORT=${17}
ACCOUNTS_EMAIL_USER=${18}
ACCOUNTS_EMAIL_TLS=${19}
ACCOUNTS_EMAIL_PASSWORD=${20}

CUSTOM_MIDDLEWARE=${21}
FORCE_LIVE=${22}
ENABLE_LIVE_WEBSOCKETS=${23}

# Configure local_settings.py
daedalus template clear
daedalus template set DOMAIN ${DOMAIN}
daedalus tempalte set DJANGO_APP_DATABASE_NAME ${DJANGO_APP_DATABASE_NAME}
daedalus template set POSTGRES_PASSWORD ${POSTGRES_PASSWORD}
daedalus template set LINODE_API_KEY ${LINODE_API_TOKEN}
daedalus template set EMAIL_SERVER_EMAIL "${EMAIL_SERVER_EMAIL}"
daedalus template set EMAIL_USE_TLS "${EMAIL_USE_TLS}"
daedalus template set EMAIL_HOST "${EMAIL_HOST}"
daedalus template set EMAIL_PORT "${EMAIL_PORT}"
daedalus template set EMAIL_HOST_USER "${EMAIL_HOST_USER}"
daedalus template set EMAIL_HOST_PASSWORD "${EMAIL_HOST_PASSWORD}"
daedalus template set EMAIL_DEFAULT_FROM_EMAIL "${EMAIL_DEFAULT_FROM_EMAIL}"
daedalus template set RECAPTCHA_PRIVATE_KEY "${RECAPTCHA_PRIVATE_KEY}"
daedalus templaet set MOCK_MACHINE_ID "${MOCK_MACHINE_ID}"
daedalus template set ACCOUNTS_EMAIL_HOST "${ACCOUNTS_EMAIL_HOST}"
daedalus template set ACCOUNTS_EMAIL_PORT "${ACCOUNTS_EMAIL_PORT}"
daedalus template set ACCOUNTS_EMAIL_USER "${ACCOUNTS_EMAIL_USER}"
daedalus template set ACCOUNTS_EMAIL_TLS "${ACCOUNTS_EMAIL_TLS}"
daedalus template set ACCOUNTS_EMAIL_PASSWORD "${ACCOUNTS_EMAIL_PASSWORD}"
daedalus template set CUSTOM_MIDDLEWARE "${CUSTOM_MIDDLEWARE}"
daedalus template set FORCE_LIVE "${FORCE_LIVE}"
daedalus template set ENABLE_LIVE_WEBSOCKETS "${ENABLE_LIVE_WEBSOCKETS}"
daedalus template render-to ${DAEDALUS_CONFIG_MODULE_PATH}/res/${TARGET}/local_settings.py ${DAEDALUS_PROJECT_PATH}/${DJANGO_APP}/local_settings.py
daedalus template clear

#!/usr/bin/env bash

DOMAIN=${1}
TARGET=${2}
DJANGO_APP=${3}

POSTGRES_PASSWORD=${4}

LINODE_API_TOKEN=${5}

EMAIL_SERVER_EMAIL=${6}
EMAIL_USE_TLS=${7}
EMAIL_HOST=${8}
EMAIL_PORT=${9}
EMAIL_HOST_USER=${10}
EMAIL_HOST_PASSWORD=${11}
EMAIL_DEFAULT_FROM_EMAIL=${12}

RECAPTCHA_PRIVATE_KEY=${13}

ACCOUNTS_EMAIL_HOST=${14}
ACCOUNTS_EMAIL_PORT=${15}
ACCOUNTS_EMAIL_USER=${16}
ACCOUNTS_EMAIL_TLS=${17}
ACCOUNTS_EMAIL_PASSWORD=${18}

# Configure local_settings.py
daedalus template clear
daedalus template set DOMAIN ${DOMAIN}
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
daedalus template set ACCOUNTS_EMAIL_HOST "${ACCOUNTS_EMAIL_HOST}"
daedalus template set ACCOUNTS_EMAIL_PORT "${ACCOUNTS_EMAIL_PORT}"
daedalus template set ACCOUNTS_EMAIL_USER "${ACCOUNTS_EMAIL_USER}"
daedalus template set ACCOUNTS_EMAIL_TLS "${ACCOUNTS_EMAIL_TLS}"
daedalus template set ACCOUNTS_EMAIL_PASSWORD "${ACCOUNTS_EMAIL_PASSWORD}"
daedalus template render-to ${DAEDALUS_CONFIG_MODULE_PATH}/res/${TARGET}/local_settings.py ${DAEDALUS_PROJECT_PATH}/${DJANGO_APP}/local_settings.py
daedalus template clear

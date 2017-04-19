#!/usr/bin/env bash

DJANGO_APP=${1}

rm ${DAEDALUS_PROJECT_PATH}/${DJANGO_APP}/local_settings.py > /dev/null 2>&1

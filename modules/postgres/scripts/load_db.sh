#!/usr/bin/env bash

. ${DAEDALUS_ROOT}/tools/bash/util.sh

DATABASE=${1}
PATH_TO_DATABASE=${2}

PATH_TO_DECOMPRESSED_DATABASE=$(fextract ${PATH_TO_DATABASE})

FULL_PATH_TO_DECOMPRESSED_DATABASE=$(myreadlink ${PATH_TO_DECOMPRESSED_DATABASE})

echo ${FULL_PATH_TO_DECOMPRESSED_DATABASE}

sudo -iu postgres -H sh -c "dropdb ${DATABASE}"
sudo -iu postgres -H sh -c "createdb ${DATABASE}"
sudo -iu postgres -H sh -c "psql ${DATABASE} < ${FULL_PATH_TO_DECOMPRESSED_DATABASE}"

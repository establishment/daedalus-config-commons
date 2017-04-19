#!/usr/bin/env bash

DATABASE=${1}
DATABASE_FILE_PATH=${2}

sudo -iu postgres -H sh -c "pg_dump ${DATABASE} > ${DATABASE_FILE_PATH}"

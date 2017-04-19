#!/usr/bin/env bash

POSTGRES_TYPE=${1}
POSTGRES_USER_PASSWORD=${2}
POSTGRES_PASSWORD=${3}

sudo apt-get install -y postgresql
sudo apt-get install -y postgresql-contrib

PATH_TO_POSTGRESQL=/etc/postgresql
POSTGRESQL_VERSION=$(ls ${PATH_TO_POSTGRESQL})
PATH_TO_POSTGRESQL_CONFIG=${PATH_TO_POSTGRESQL}/${POSTGRESQL_VERSION}/main

cp ${DAEDALUS_CONFIG_MODULE_PATH}/res/${POSTGRES_TYPE}/pg_hba.conf ${PATH_TO_POSTGRESQL_CONFIG}/pg_hba.conf
cp ${DAEDALUS_CONFIG_MODULE_PATH}/res/${POSTGRES_TYPE}/postgresql.conf ${PATH_TO_POSTGRESQL_CONFIG}/postgresql.conf

echo "postgres:${POSTGRES_USER_PASSWORD}" | chpasswd

sudo -iu postgres -H sh -c "psql -c \"ALTER ROLE postgres WITH PASSWORD '${POSTGRES_PASSWORD}';\""

service postgresql stop
service postgresql start

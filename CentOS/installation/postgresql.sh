#!/usr/bin/bash

yum --assumeyes install postgresql-server

USER_NAME='postgres'
PGDATA='/usr/local/pgsql/data/'
adduser "${USER_NAME}"
mkdir --parent "${PGDATA}"
chown  "${USER_NAME}" "${PGDATA}"
su - "${USER_NAME}"
initdb --pgdata="${PGDATA}"


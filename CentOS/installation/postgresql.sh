#!/usr/bin/bash


## https://www.postgresql.org/docs/current/static/install-short.html
yum --assumeyes install postgresql-server
 
## create links in /usr/local/bin/
cat <<"END_OF_FILE" > '/usr/local/bin/psql'
#!/usr/bin/bash

/usr/bin/psql --username='postgres' "$@"
 
END_OF_FILE
chmod a+x '/usr/local/bin/psql'
  
USER_NAME='postgres'
PGDATA='/usr/local/pgsql/data/'
adduser "${USER_NAME}"
mkdir --parent "${PGDATA}"
chown  "${USER_NAME}" "${PGDATA}"
su - "${USER_NAME}"
initdb --pgdata="${PGDATA}"

################################################################################
########  start the database server using:                              ########
########      postgres -D /var/lib/pgsql/data                           ########
########  or                                                            ########
########      pg_ctl -D /var/lib/pgsql/data -l logfile start            ########
################################################################################

pg_ctl --pgdata="${PGDATA}" --log='logfile' start


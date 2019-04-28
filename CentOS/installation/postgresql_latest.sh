
## Finding distribution/architecture 
## https://yum.postgresql.org/findingdistro.php
distribution=`cat /etc/redhat-release | head --lines=1`
distribution_release=`echo "$distribution" | sed --silent 's/^[^0-9]*\([0-9]*\)[^0-9]\?.*$/\1/p'` 
architecture=`uname --machine | head --lines=1`
 
## Download and install 
cd /usr/local/
rpm_url=`curl https://yum.postgresql.org/repopackages.php | sed --silent 's!^.*"\(https://download.postgresql.org/pub/repos/yum/\([^/"]*\)[^"]*/rhel-\([0-9]*\)-\([^/"]*\)/[^/"]*\.rpm\)".*CentOS.*$!\2\t\3\t\4\t\1!p' | awk '$1 ~ /^[0-9]+(\.[0-9]*)?/' | awk '$2 == '"$distribution_release" | awk '$3 == "'"$architecture"'"' | sort --version-sort --reverse --key=1 | awk '{print $4}' | head --lines=1`
rpm_file=${rpm_url##*/} 
curl "${rpm_url}" --output "${rpm_file}" 
yum install --assumeyes "$rpm_file" epel-release
prog_name=`yum search postgresql | sed --silent 's/^\(postgresql[0-9]\+-server\).*$/\1/p' | sort --version-sort --reverse | head --lines=1` 
yum install --assumeyes "$prog_name" 
 
## create links in /usr/local/bin/
bin_dir=`ls --directory /usr/pgsql-*/bin/ | sort --version-sort --reverse | head --lines=1` 
path_postgres=`ls "${bin_dir}postgres"` 
path_psql=`ls "${bin_dir}psql"` 
path_pgctl=`ls "${bin_dir}pg_ctl"`
path_initdb=`ls "${bin_dir}initdb"`
ln --symbolic "${path_postgres}" '/usr/local/bin/postgres' --force
ln --symbolic "${path_pgctl}"    '/usr/local/bin/pg_ctl'   --force
ln --symbolic "${path_initdb}"   '/usr/local/bin/initdb'   --force
cat <<"END_OF_FILE" | sed 's!/usr/bin/psql!'"$path_psql"'!' > '/usr/local/bin/psql'
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

 

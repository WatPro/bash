#!/bin/bash

####################################################################################################
########## Install MongoDB (manually)                                                     ##########
########## Tested on CentOS 7.4 (new changes are not tested yet)                          ##########
########## Dependencies: (None)                                                           ##########
####################################################################################################
 
cd /usr/local
 
####################################################################################################
########## Set up path and filenames                                                      ##########
########## Read the articles:                                                             ##########
########## https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/           ##########
########## https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-centos-7 #####
########## Figure out the variables used in Yellowdog Updater, Modified:                  ##########
########## # python2 -c 'import yum; yb=yum.YumBase(); print(yb.conf.yumvar)'             ##########
####################################################################################################
releasever=`python2 -c 'import yum; yb=yum.YumBase(); print(yb.conf.yumvar)' | sed --silent "s/^.*'releasever':[ ]*'\([^']\+\)'.*$/\1/p"`
REDHAT_URL="https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/"
MDB_VERSION=`curl "${REDHAT_URL}" | sed --silent "s/^.*href='\([0-9]\+\(\.[0-9]\+\)\?\)'.*$/\1/p" | sort --version-sort | tail --lines=1 `
MDB_DIR_URL="${REDHAT_URL}${MDB_VERSION}/x86_64/RPMS/"
MDB_RPM_LIST=`curl "${MDB_DIR_URL}" | sed --silent "s/^.*href='\([^']\+\.rpm\)'.*$/\1/p"`
FILES=(mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools mongodb-org)
FILENAMES=()
for FILE in ${FILES[@]}
do
    FILENMAE=`echo "${MDB_RPM_LIST}" | grep "${FILE}-${MDB_VERSION}" | sort --version-sort | tail --lines=1 `
    FILENAMES+=("${FILENMAE}")
    echo Downloading "${MDB_DIR_URL}${FILENMAE}"
    curl "${MDB_DIR_URL}${FILENMAE}" --output "${FILENMAE}"
done

rpm --upgrade -v --hash --replacepkgs ${FILENAMES[@]} 

for FILENAME in ${FILENAMES[@]}
do
    rm --force "./$FILENAME"
done
 
mongo --version
 
sudo systemctl start mongod

 

#!/bin/bash

####################################################################################################
########## Install MongoDB (manually)                                                     ##########
########## Tested on CentOS 7.4                                                           ##########
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
REDHAT_URL='https://repo.mongodb.org/yum/redhat/7/mongodb-org/'
MDB_VERSION=`curl "${REDHAT_URL}" | sed --silent "s/^.*href='\([0-9]\+\(\.[0-9]\+\)\?\)'.*$/\1/p" | sort --numeric-sort | tail --lines=1 `
MDB_DIR_URL="${REDHAT_URL}${MDB_VERSION}/x86_64/RPMS/"
FILES=(mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools mongodb-org)
for FILE in ${FILES[@]}
do
    echo Downloading $FILE
done


F_PATH='https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/RPMS/'
FILES=(mongodb-org-mongos-3.4.10-1.el7.x86_64.rpm mongodb-org-server-3.4.10-1.el7.x86_64.rpm mongodb-org-shell-3.4.10-1.el7.x86_64.rpm mongodb-org-tools-3.4.10-1.el7.x86_64.rpm mongodb-org-3.4.10-1.el7.x86_64.rpm)

for FILE in ${FILES[@]}
do
    echo Downloading $FILE
    curl --remote-name $F_PATH$FILE
done

rpm --upgrade -v --hash --replacepkgs ${FILES[@]} 

for FILE in ${FILES[@]}
do
    rm --force ./$FILE
done


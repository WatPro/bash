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


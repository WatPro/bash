#!/bin/bash

################################################################################
########## Install Git                                                ##########
########## Tested on Raspbian 9                                       ##########
################################################################################

if [ `whoami` != root ]; then 
    echo 'SUperuser DO (sudo) is required. ' 1>&2
    exit 1
fi

############################################################
# instal git using Advanced Package Tool                   #
############################################################
apt-get update
apt-get --assume-yes install git


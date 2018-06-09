#!/bin/bash

####################################################################################################
########## Install (up-to-date) Git                                                       ##########
########## Tested on CentOS 7.4                                                           ##########
########## Dependencies: (None)                                                           ##########
####################################################################################################
 
G_PATH=/usr/local
G_URL=https://github.com/git/git.git
G_DIR=${G_URL##*/}
G_DIR=${G_DIR%.*}
 
yum --assumeyes install git
yum --assumeyes groupinstall "Development Tools" 
yum --assumeyes install openssl-devel libcurl-devel expat-devel perl-devel 
cd $G_PATH
git clone "$G_URL"
cd "$G_DIR"
make 
make prefix="$G_PATH" install

rm --force --recursive "$G_PATH/$G_DIR"
 
git --version


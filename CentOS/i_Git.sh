#!/bin/bash

####################################################################################################
########## Install (up-to-date) Git                                                       ##########
########## Tested on CentOS 7.4                                                             ##########
########## Dependencies: (None)                                                           ##########
####################################################################################################
 
G_PATH=/usr/local
 
yum -y install git
yum -y groupinstall "Development Tools" 
yum -y install openssl-devel libcurl-devel expat-devel perl-devel 
cd $G_PATH
git clone https://github.com/git/git
cd git
make 
make prefix=$G_PATH install
 
git --version


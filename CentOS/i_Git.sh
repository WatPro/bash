#!/bin/bash

####################################################################################################
########## Install (up-to-date) Git                                                       ##########
########## Tested on CentOS 7                                                             ##########
####################################################################################################
 
yum -y install git
yum -y groupinstall "Development Tools" 
yum -y install openssl-devel libcurl-devel expat-devel perl-devel 
cd /usr/ 
git clone https://github.com/git/git
cd git
make 
make prefix=/usr install
 
git --version


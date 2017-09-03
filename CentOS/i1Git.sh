#!/bin/bash

# This script is designed to install an up-to-date version of Git
# on CentOS 7

# install git and MySQL
yum -y install git
yum -y groupinstall "Development Tools" 
yum -y install openssl-devel libcurl-devel expat-devel perl-devel 
cd /usr/ 
git clone https://github.com/git/git
cd git
make 
make prefix=/usr install

git --version

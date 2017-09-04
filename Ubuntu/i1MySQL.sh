#!/bin/bash

# This script is designed to install MySQL
# on a newly installed Ubuntu 16.04
# Notice: Lots of interactions needed 

apt-get update
apt-get install mysql-server --assume-yes
mysql_secure_installation
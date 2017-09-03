#!/bin/bash
 
# This script is designed for setting up an new user
# on Ubuntu 16.04
 
read -p  'Username: ' USERVAR
adduser $USERVAR 
gpasswd --add $USERVAR sudo
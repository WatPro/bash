#!/bin/bash

################################################################################
########## Due to security concerns, hosts stored in ~/.ssh/known_hosts ########
########## are usually hashed by default.                             ##########
########## For tutoring purposes, here disables this setting.         ##########
########## Tested on Raspbian 9.1                                     ##########
################################################################################

if [ `whoami` != root ]; then 
    echo 'SUperuser DO (sudo) is required. ' 1>&2
    exit 1
fi

SSH_CONFIG=/etc/ssh/ssh_config
sed --in-place 's/\(HashKnownHosts \)[a-z]\+/\1no/' "$SSH_CONFIG"
############################################################
#              's/\(HashKnownHosts \)[a-z]\+/\1yes/'       #
############################################################
cat "$SSH_CONFIG"


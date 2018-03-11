#!/bin/bash

CHANGE_PASSWORD () {
    local USER=$1
    local PASS=$2
    echo ${PASS} | passwd --stdin root
}

if [ -n "$1" ]
then
    PASS="$1"
    CHANGE_PASSWORD 'root' ${PASS}
fi
 

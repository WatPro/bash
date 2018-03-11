#!/bin/bash

CHANGE_PASSWORD () {
    local USER=$1
    local PASS=$2
    echo ${PASS} | passwd --stdin ${USER}
}

if [ -n "$1" ]
then
    PASS="$1"
    CHANGE_PASSWORD 'root' ${PASS}
fi
 

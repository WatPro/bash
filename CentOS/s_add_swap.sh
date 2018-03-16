#!/bin/bash
 
df --human-readable
 
add_swap () {
    if [ -n "$1" ]
    then
        SWAPFILE="$1"
    else 
        SWAPFILE=/swapfile
    fi 
    if [ -n "$2" ]
    then
        SIZE="$2"
    else
        SIZE='1G'
    fi 
    if [ -f ${SWAPFILE} ]
    then
        echo "File Exists: ${SWAPFILE}" 
    else 
        fallocate --length ${SIZE} ${SWAPFILE}
        chmod 600 ${SWAPFILE}
        ls --human-readable -l ${SWAPFILE}
    
        mkswap ${SWAPFILE}
        swapon ${SWAPFILE}
    fi
}
 
add_swap /swapfile
 
free --mega
cat /proc/swaps
 

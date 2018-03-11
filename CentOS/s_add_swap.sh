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
    fallocate --length ${SIZE} ${SWAPFILE}
    chmod 600 ${SWAPFILE}
    ls --human-readable -l ${SWAPFILE}
    
    mkswap ${SWAPFILE}
    swapon ${SWAPFILE}
}
 
add_swap /swapfile
 
free --mega
cat /proc/swaps
 

#!/bin/bash

################################################################################
########## Bad Login Attempts Blacklisting                            ##########
########## write high-frequent bad login attempts to iptables packet  ##########
########## filtering                                                  ##########
########## Tested on CentOS 7.3                                       ##########
################################################################################

THRESHOLD=100
LAST_IP=/tmp/last_ip_list
LASTB_IP=/tmp/lastb_ip_list
BLACKLIST=/tmp/blacklist_ip

lastb -i | cut --characters=23-38 | tr --delete ' ' | grep --regexp='^[1-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$LASTB_IP" 
 
last -i | cut --characters=23-38 | tr --delete ' ' | grep --regexp='^[1-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$LAST_IP" 
 
iptables -L INPUT --numeric | awk 'NR<=2 || /^DROP /' | cut --characters=21-40 | tr --delete ' ' | grep --regexp='^[1-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$BLACKLIST"


echo 'INPUT Frames Will Be DROPped From Below Sources: '
grep --invert-match --file="$LAST_IP" "$LASTB_IP" | grep --invert-match --file="$BLACKLIST" | sort --ignore-nonprinting --random-sort | uniq --count | sort --numeric-sort --reverse | while read line
do
    COUNT=`echo "$line" | cut --fields=1 --delimiter=' '` 
    if [ $COUNT -lt $THRESHOLD ] 
    then 
        break 
    fi 
    DEL_IP=`echo "$line" | cut --fields=2 --delimiter=' '` 
    iptables --append INPUT --source "$DEL_IP" --jump DROP 
    echo "$line"
done

iptables -L INPUT --numeric | awk 'NR<=2 || /^DROP /'
 
echo ' ' 
echo 'The Failed Attempts Below Are Currently Whitelisted: ' 
grep --file="$LAST_IP" "$LASTB_IP" | grep --invert-match --file="$BLACKLIST" | sort --ignore-nonprinting --random-sort | uniq --count | sort --numeric-sort --reverse
 
#rm --force "$LAST_IP" "$LASTB_IP"



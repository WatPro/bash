#!/bin/bash

################################################################################
########## Bad Login Attempts Blacklisting                            ##########
########## write high-frequent bad login attempts to iptables packet  ##########
########## filtering                                                  ##########
########## Tested on CentOS 7.3                                       ##########
################################################################################

LOGDIR="$1"
THRESHOLD=100
LAST_IP=/tmp/last_ip_list
LASTB0_IP=/tmp/lastb_ip_list0
LASTB_IP=/tmp/lastb_ip_list
BLACKLIST=/tmp/blacklist_ip

writelog() {
    if [ -w "$LOGDIR" ]
    then
        echo "$1" >> "$LOGDIR"
    fi
}

writelog '##############################'
lastb -i > "$LASTB0_IP"
writelog "`cat "$LASTB0_IP" | tail --lines=1`"

cat "$LASTB0_IP" | cut --characters=23-38 | tr --delete ' ' | grep --regexp='^[1-9][0-9]\{0,2\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$LASTB_IP" 
last -i | cut --characters=23-38 | tr --delete ' ' | grep --regexp='^[1-9][0-9]\{0,2\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$LAST_IP" 
iptables -L INPUT --numeric | awk 'NR<=2 || /^DROP /' | cut --characters=21-40 | tr --delete ' ' | grep --regexp='^[1-9][0-9]\{0,2\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$' > "$BLACKLIST" 

echo 'INPUT Packets Will Be DROPped From Below Sources: '
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
    writelog "$line"
done
writelog "`date`"

iptables -L INPUT --numeric | awk 'NR<=2 || /^DROP /'
 
echo ' ' 
echo 'The Failed Attempts Below Are Currently Whitelisted: ' 
grep --file="$LAST_IP" "$LASTB_IP" | grep --invert-match --file="$BLACKLIST" | sort --ignore-nonprinting --random-sort | uniq --count | sort --numeric-sort --reverse
 
#rm --force "$LAST_IP" "$LASTB_IP" "$BLACKLIST"



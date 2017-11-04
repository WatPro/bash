#!/bin/bash

################################################################################
##########     Add Or Rewrite A Secondary IP Address to CentOS        ##########
##########     iproute2 Is Used                                       ##########
################################################################################

if ( echo $1 |  egrep --quiet ^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$ ) 
then
 
T_INTERFACE=$( ip link | sed --regexp-extended --silent 's/.* (eth[0-9]*): .*/\1/p' | sed --silent '1p' )
T_MAINIP=$( ip address show | sed -rn "s/.*inet ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\/[0-9]{1,2}.*$T_INTERFACE$/\1/p" )
T_NETMASK=$( echo $(ipcalc --netmask $(ip address show | sed -rn "s/.*inet ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}).*$T_INTERFACE$/\1/p")) | sed -rn 's/NETMASK=(.*)/\1/p' ) 
T_GATEWAY=$( ip route show | sed --regexp-extended --silent 's/.*via ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) .*/\1/p' | sed --silent '1p' ) 
IFCFG_PATH=/etc/sysconfig/network-scripts/
IFCFG_FILE=${IFCFG_PATH}ifcfg-$T_INTERFACE
grep --silent '^BOOTPROTO=' $IFCFG_FILE && sed --in-place 's/^BOOTPROTO=.*/BOOTPROTO="static"/' $IFCFG_FILE || echo 'BOOTPROTO="static"' >> $IFCFG_FILE  
grep --silent '^IPADDR=' $IFCFG_FILE && sed --in-place "s/^IPADDR=.*/IPADDR=\"$T_MAINIP\"/" $IFCFG_FILE || echo "IPADDR=\"$T_MAINIP\"" >> $IFCFG_FILE 
grep --silent '^NETMASK=' $IFCFG_FILE && sed --in-place "s/^NETMASK=.*/NETMASK=\"$T_NETMASK\"/" $IFCFG_FILE || echo "NETMASK=\"$T_NETMASK\"" >> $IFCFG_FILE 
grep --silent '^GATEWAY=' $IFCFG_FILE && sed --in-place "s/^GATEWAY=.*/GATEWAY=\"$T_GATEWAY\"/" $IFCFG_FILE || echo "GATEWAY=\"$T_GATEWAY\"" >> $IFCFG_FILE 
ifup $T_INTERFACE 
cat $IFCFG_FILE 
 
T_INTERFACE_NEW=$T_INTERFACE:1
IFCFG_FILE_NEW=${IFCFG_PATH}ifcfg-$T_INTERFACE_NEW
cat << END_OF_FILE > $IFCFG_FILE_NEW
DEVICE="$T_INTERFACE_NEW"
BOOTPROTO="static"
IPADDR="$1"
ONBOOT="yes"
END_OF_FILE
ifup $T_INTERFACE_NEW
ip address 

else
 
echo 'New IP Address ($1) is needed. '

fi
 
 
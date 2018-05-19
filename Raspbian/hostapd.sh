#!/bin/bash

HOSTAPD_CONF='/etc/hostapd/hostapd.conf'
HOSTAPD_SSID='RaspberryAccessPoint'
HOSTAPD_PASSD='password'
HOSTAPD_LOG='/var/log/hostapd.log'
 
HOSTAPD=`which hostapd | head --lines=1`
if [ ! -n "$HOSTAPD" ]
then
   sudo apt-get --assume-yes install hostapd  
fi
HOSTAPD=`which hostapd | head --lines=1`
if [ ! -n "$HOSTAPD" ]
then
   exit 1 
fi
 
BRIDGE0=`ip link show | sed --silent 's/^[0-9]\+:\s\([^:]\+\):.*$/\1/p' | grep br0` 
if [ ! -n "$BRIDGE0" ]
then
   sudo ip link add name br0 type bridge  
fi
sudo ip link set br0 up
sudo ip link set eth0 up
sudo ip link set eth0 master br0 
 
sudo mkdir --parent "${HOSTAPD_CONF%/*}/"
sudo touch ${HOSTAPD_CONF}
sudo chmod a+w ${HOSTAPD_CONF}
sudo cat <<END_OF_FILE > ${HOSTAPD_CONF}
interface=wlan0
bridge=br0
driver=nl80211
ssid=${HOSTAPD_SSID}
hw_mode=g
channel=1
wmm_enabled=0
macaddr_acl=0
auth_algs=3
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=${HOSTAPD_PASSD}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
END_OF_FILE

PID_FILE='/var/run/hostapdaemon.pid'
if [ -f ${PID_FILE} ]
then
    sudo kill `cat ${PID_FILE}` 
    sudo rm --force "$PID_FILE"
fi

sudo hostapd -dd -B -P "${PID_FILE}" -f "${HOSTAPD_LOG}" "${HOSTAPD_CONF}" 
 

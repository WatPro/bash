### HOST Access Point Daemon (hostapd)
 
```bash
cat hostapd.sh | sed "s/^HOSTAPD_SSID=.*$/HOSTAPD_SSID='RaspberryAP'/; s/^HOSTAPD_PASSD=.*$/HOSTAPD_PASSD='password'/" | sudo bash - 
```
 

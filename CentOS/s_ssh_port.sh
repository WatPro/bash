#!/bin/bash 
 
################################################################################
##########     Change Port Used For SSH (Secure Shell) Service        ##########
##########     Tested on CentOS 8 with SELinux                        ##########
################################################################################
 
arg_port="$1"
 
SSHD_CONFIG=/etc/ssh/sshd_config
FIREWALLD_SSH=/usr/lib/firewalld/services/ssh.xml
 
if [[ "${arg_port}" =~ ^[1-9][0-9]{0,4}$ && "$1" -le 65535 ]]
then
    PORT="${arg_port}"
    which semanage > /dev/null
    if [ $? -eq 0 ] 
    then
      (semanage port --modify --type ssh_port_t --proto tcp "${PORT}") || 
      (semanage port   --add --type ssh_port_t --proto tcp "${PORT}")
    fi 
    sed --in-place "s/^[#]\?\(Port \)[1-9][0-9]\{0,4\}$/\1$PORT/" "$SSHD_CONFIG"
    if [[ -e "$FIREWALLD_SSH" ]]
    then 
        sed --in-place "s/port=\"[1-9][0-9]\{0,4\}\"/port=\"$PORT\"/" "$FIREWALLD_SSH"
        if [ running = "$(firewall-cmd --state 2>&1)" ] 
        then
            firewall-cmd --reload
            firewall-cmd --list-services
            firewall-cmd --info-service=ssh
        fi 
    fi
    # restart SSH 
    service sshd restart
fi
 

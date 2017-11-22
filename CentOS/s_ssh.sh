#!/usr/bin/env bash

####################################################################################################
########## Tested on CentOS 7.3                                                           ##########
####################################################################################################

# change the setting 
sed --in-place 's/^[#]\?\(PasswordAuthentication \)\(yes\|no\)$/\1no/' /etc/ssh/sshd_config
sed --in-place 's/^[#]\?\(UseDNS \)\(yes\|no\)$/\1no/' /etc/ssh/sshd_config
# check if the changes were processed
cat /etc/ssh/sshd_config 
# restart SSH 
service sshd restart



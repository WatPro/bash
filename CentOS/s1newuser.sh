#!/bin/bash
 
# This script is designed for setting up an new user
# on CentOS 7. 
# Not tested yet 
 
read -p  'Username: ' USERVAR
adduser $USERVAR 
echo "The password "
echo "    must consist of at least 5 different characters "
echo "    must not be                                     " 
echo "        a palindrome, like 123454321                "
echo "        shorter than 8 characters                   "
#    "        based on a dictionary word                  "
#    "    must not                                        "
#    "        contain the user name in some form          "
passwd $USERVAR
gpasswd -a $USERVAR wheel


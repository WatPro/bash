#!/bin/bash
 
################################################################
######## Install The Latest Stable Python 3 Release     ########
######## Tested on CentOS 7.3                           ########
################################################################
 
yum --assumeyes groupinstall 'development tools'
yum --assumeyes install openssl-devel
 
P_PATH='/usr/local'
cd "$P_PATH" 
 
DOWNLOAD_PAGE0=https://www.python.org/downloads/
REG_EXP='\/ftp\/python\/.*Python 3'
DOWNLOAD_PAGE1=`curl --silent $DOWNLOAD_PAGE0 | grep "$REG_EXP" | head --lines=1 | sed --silent 's/.*\"\(http[s]:\/\/www\.python.org\/ftp\/python\/[^\/]*\/\).*/\1/p'`
if [ -z $DOWNLOAD_PAGE1 ]
then
    echo 'Download Page Cannot Be Found. Exit. ' >&2
    exit 1
fi
FILE_NAME=`curl --silent $DOWNLOAD_PAGE1 | sed --silent 's/.*"\([Pp]ython-[23]\.[0-9]*\.[0-9]*\.tgz\)\".*/\1/p'`
if [ -z $FILE_NAME ]
then
    echo 'Source File Cannot Be Found. Exit. ' >&2
    exit 1
fi
FILE_URL="$DOWNLOAD_PAGE1$FILE_NAME"
 
############################################################
# Download Source                                          #
############################################################
curl --remote-name $FILE_URL
FOLDER_NAME=`tar --list --gzip --file=$FILE_NAME | head --lines=1 | cut --delimiter='/' --fields=1`
tar --extract --verbose --file=$FILE_NAME
cd "$P_PATH/$FOLDER_NAME"
 
############################################################
# Install                                                  #
# Read More:                                               #
# https://docs.python.org/3/using/unix.html                #
############################################################
./configure --prefix="$P_PATH"
make
make install
 
rm --force --recursive "$P_PATH/$FILE_NAME" "$P_PATH/$FOLDER_NAME"
 
############################################################
# Optioanl.                                                #
# IPython is a better alternative than the Python 3 native #
# interactive mode.                                        #
# # pip3 install ipython                                   #
# or                                                       #
# # python3 -m pip install ipython                         #      
############################################################
 

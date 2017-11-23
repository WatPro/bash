#!/bin/bash
 
yum groupinstall -y 'development tools'
yum install -y zlib-dev openssl-devel
 
P_PATH='/usr/local'
cd "$P_PATH" 
 
DOWNLOAD_PAGE0=https://www.python.org/downloads/
DOWNLOAD_PAGE1=`curl --silent $DOWNLOAD_PAGE0 | grep 'Python 3' | head --lines=1 | sed --silent 's/.*\"\(http[s]:\/\/www\.python.org\/ftp\/python\/[^\/]*\/\).*/\1/p'`
FILE_NAME=`curl --silent $DOWNLOAD_PAGE1 | sed --silent 's/.*"\([Pp]ython-[0-9]\.[0-9]*\.[0-9]*\.tgz\)\".*/\1/p'`
FILE_URL="$DOWNLOAD_PAGE1$FILE_NAME"
 
curl --remote-name $FILE_URL
FOLDER_NAME=`tar --list --gzip --file=$FILE_NAME | head --lines=1 | cut --delimiter='/' --fields=1`
tar --extract --verbose --file=$FILE_NAME
cd "$P_PATH/$FOLDER_NAME"
 
./configure --prefix="$P_PATH"
make
make install
 
rm --force --recursive "$P_PATH/$FILE_NAME" "$P_PATH/$FOLDER_NAME"




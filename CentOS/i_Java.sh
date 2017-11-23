#!/bin/bash

####################################################################################################
########## Install Oracle Java                                                            ##########
########## Tested on CentOS 7.4                                                           ##########
########## Dependencies: (None)                                                           ##########
##########                                                                                ##########
####################################################################################################

JAVA_PAGE0=http://www.oracle.com/technetwork/java/javase/downloads/index.html
JAVA_HOST=`echo $JAVA_PAGE0 | sed --quiet 's/\(\(http[s]\?:\/\/\|\)[^\/]*\)\(\/.*\|\)/\1/p'`

RE_EX='<h3 id=\"javasejdk\"><a name=\"\([^\"]*\)\" href=\"\([^\"]*\)\">\(.*\)<\/a><\/h3>'
LINE=`curl --silent $JAVA_PAGE0 | grep "$RE_EX" | head --lines=1`
VER=`echo $LINE | sed --quiet "s/.*$RE_EX.*/\1/p"`
JAVA_PAGE1="$JAVA_HOST`echo $LINE | sed --quiet "s/.*$RE_EX.*/\2/p"`"
JDK_URL=`curl --silent $JAVA_PAGE1 | sed --silent 's/.*"filepath":"\([^"]*.rpm\)".*/\1/p'` 

echo "Downloading Java Development Kit ($VER) for Linux"
 
JDK_FILENAME=${JDK_URL##*/}
JAVA_DIR=/usr/java/
mkdir --parents $JAVA_DIR 
cd $JAVA_DIR
curl --location --header "Cookie: oraclelicense=accept-securebackup-cookie" --remote-name $JDK_URL
rpm --upgrade -v --hash --replacepkgs $JDK_FILENAME
rm --force $JDK_FILENAME 
 
####################################################################################################
########## Check if installed correctlly                                                  ##########
####################################################################################################
which java javac
java --version


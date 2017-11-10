#!/bin/bash

####################################################################################################
########## Install Oracle Java                                                            ##########
########## Tested on CentOS 7.4                                                           ##########
########## Dependencies: (None)                                                           ##########
##########                                                                                ##########
####################################################################################################

echo Downloading Java Development Kit
####################################################################################################
########## Find out download link of Java for Linux:                                      ##########
########## http://www.oracle.com/technetwork/java/javase/downloads/index.html             ##########
####################################################################################################
JDK_URL=http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.rpm
 
JDK_FILENAME=${JDK_URL##*/}
JAVA_DIR=/usr/java/
if [ ! -d $JAVA_DIR ]
then
    mkdir $JAVA_DIR 
fi
cd $JAVA_DIR
curl --silent --location --header "Cookie: oraclelicense=accept-securebackup-cookie" --remote-name $JDK_URL
rpm --upgrade -v --hash --replacepkgs $JDK_FILENAME
rm --force $JDK_FILENAME 

which java javac
java --version


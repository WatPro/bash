#!/bin/bash

# This script is designed to download Maven 
# in a newly installed CentOS 7. 

# Download Java Development Kit 
echo Downloading Java Development Kit
JDK_URL=http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm
JDK_FILENAME=${JDK_URL##*/}
JAVA_DIR=/usr/java/
if [ ! -d $JAVA_DIR ]
then
    mkdir $JAVA_DIR 
fi
cd $JAVA_DIR
curl -s -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -O $JDK_URL
yum -y localinstall $JDK_FILENAME
rm -f $JDK_FILENAME 


# Download Maven 
echo Downloading Maven 
MVN_URL=http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
MVN_FILENAME=${MVN_URL##*/}
JAVA_DIR=/usr/java/
if [ ! -d $JAVA_DIR ]
then
    mkdir $JAVA_DIR 
fi
cd $JAVA_DIR
curl -s -O $MVN_URL
MVN_HOME=$PWD/$(tar -tf $MVN_FILENAME | head -n1 | cut -d / -f 1)
tar -zxf $MVN_FILENAME
PATH=$PATH:$MVN_HOME/bin
 
# Set Up the Global Variables 
echo Writing Up To /etc/profile.d/CUSTOM_mvn_var.sh
BASH_FILE=/etc/profile.d/CUSTOM_mvn_var.sh
if [ -e $BASH_FILE ] 
then 
    rm -f $BASH_FILE
fi 
echo "#!/bin/bash" >> $BASH_FILE 
echo " " >> $BASH_FILE 
echo "# Maven VARIABLE Setting " >> $BASH_FILE
echo " " >> $BASH_FILE
echo "PATH=$PATH" >> $BASH_FILE
export PATH >> $BASH_FILE

#!/usr/bin/bash

which beeline 1>/dev/null 2>&1
if [ $? -ne 0 ]
then
  bash install_hive.sh
fi


bashrc="${HOME}/.bashrc"


JAVA_HOME_PATH='/usr/lib/jvm/java-11-amazon-corretto.x86_64'
if [[ -z ${JAVA_HOME} ]]
then
  sed --in-place '/^export JAVA_HOME=/d' ${bashrc}
  echo "export JAVA_HOME=\"${JAVA_HOME_PATH}\""
  echo "export JAVA_HOME=\"${JAVA_HOME_PATH}\"" >> ${bashrc}
fi

if [ -f 'HADOOP_HOME.txt' ]
then
  HADOOP_HOME_PATH=`cat HADOOP_HOME.txt`
fi
if [[ (-z ${HADOOP_HOME}) && (-n ${HADOOP_HOME_PATH}) ]]
then
  sed --in-place '/^export HADOOP_HOME=/d' ${bashrc}
  echo "export HADOOP_HOME=\"${HADOOP_HOME_PATH}\""
  echo "export HADOOP_HOME=\"${HADOOP_HOME_PATH}\"" >> ${bashrc}
fi


if [ -f 'HIVE_HOME.txt' ]
then
  HIVE_HOME_PATH=`cat HIVE_HOME.txt`
fi
if [[ (-z ${HIVE_HOME}) && (-n ${HIVE_HOME_PATH}) ]]
then
  sed --in-place '/^export HIVE_HOME=/d' ${bashrc}
  sed --in-place '/^export PATH=.* ## adding hive to path/d' ${bashrc}
  echo "export HIVE_HOME=\"${HIVE_HOME_PATH}\""
  echo "export HIVE_HOME=\"${HIVE_HOME_PATH}\"" >> ${bashrc}
  echo "export PATH=\"\$PATH:${HIVE_HOME_PATH}bin\" ## adding hive to path"
  echo "export PATH=\"\$PATH:${HIVE_HOME_PATH}bin\" ## adding hive to path" >> ${bashrc}
fi


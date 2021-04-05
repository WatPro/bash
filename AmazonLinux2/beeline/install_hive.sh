#!/usr/bin/bash

## https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-InstallingHivefromaStableRelease
## sudo yum install --assumeyes java-1.8.0-openjdk # already installed 
## export JAVA_HOME='/usr/lib/jvm/java-11-amazon-corretto.x86_64'

dir="$1"
if [[ ! -d "${dir}" ]] && [[ -d "${HOME}" ]]
then
  dir="${HOME}"
fi


curl 'https://www.apache.org/dyn/closer.cgi/hive/' |
  sed --silent '/We suggest the following mirror/,$p' |
  sed '/Other mirror sites are suggested below/,$d' |
  sed --silent 's!^.* href="\([^"]*/hive/\)".*$!\1!p' > hive_suggest_downloadsite.txt

url=`cat hive_suggest_downloadsite.txt`'hive-3.1.2/apache-hive-3.1.2-bin.tar.gz'
file="${url##*/}"
curl "${url}" --output "${file}"

tar --extract --ungzip --verbose --file="${file}" --directory="${dir}"
echo "${dir}/${file%.tar.gz}/" > HIVE_HOME.txt
HIVE_HOME=`cat HIVE_HOME.txt`
# export PATH=$PATH:$HIVE_HOME/bin


curl 'https://www.apache.org/dyn/closer.cgi/hadoop/common/' |
  sed --silent '/We suggest the following mirror/,$p' |
  sed '/Other mirror sites are suggested below/,$d' |
  sed --silent 's!^.* href="\([^"]*/hadoop/common/\)".*$!\1!p' > hadoop_suggest_downloadsite.txt

hurl=`cat hadoop_suggest_downloadsite.txt`"hadoop-3.2.1/hadoop-3.2.1.tar.gz" 
hfile="${hurl##*/}"
curl "${hurl}" --output "${hfile}"

tar --extract --ungzip --verbose --file="${hfile}" --directory="${dir}"
echo "${dir}/${hfile%.tar.gz}" > HADOOP_HOME.txt
# export HADOOP_HOME=`cat HADOOP_HOME.txt`


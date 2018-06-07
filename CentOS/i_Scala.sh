#!/usr/bin/bash

if [ ! -n "`which javac`" ]
then
    sudo yum --assumeyes install java-openjdk
fi

scala_web='https://scala-lang.org/download/'
scala_rpm=`curl "${scala_web}" | sed --silent 's/^.*"\(http[s]:\/\/.*\.rpm\)".*$/\1/p'`
if [ ! -n "${scala_rpm##*/}" ]
then
    exit 1
fi
download_url="${baseurl}/${rpmfile}"
curl --location "${scala_rpm}" --output "${scala_rpm##*/}"
sudo yum --assumeyes install "${scala_rpm##*/}"
rm --force "${scala_rpm##*/}"


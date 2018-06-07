#!/usr/bin/bash

if [ ! -n "`which javac`" ]
then
    sudo yum --assumeyes install java-openjdk
fi

baseurl=`curl https://bintray.com/sbt/rpm/rpm | sed --silent 's/^baseurl=//p'`
rpmfile=`curl --location "${baseurl}" | sed --silent 's/^.*"\(sbt[^"]*.rpm\)".*$/\1/p' | tail --lines=1`
download_url="${baseurl}/${rpmfile}"
curl --location "${download_url}" --output "${rpmfile}"
sudo yum --assumeyes install "${rpmfile}"
rm --force "${rpmfile}"



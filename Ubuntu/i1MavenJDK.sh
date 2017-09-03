#!/bin/bash

# This script is designed to download Maven
# in a newly installed Ubuntu 16.04
# with default JDK

apt-get update
apt-get install default-jdk --assume-yes
apt-get install maven --assume-yes

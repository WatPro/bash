#!/bin/bash

# This script initialize development environment 
# Git, MySQL, Java, Maven 

./i1Git.sh 

yum -y install mysql 
 
./i1MavenJava.sh 

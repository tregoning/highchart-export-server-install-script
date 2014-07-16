#!/bin/bash -
###############################################################################
# File:          "install.sh"
#
# Description:   Install script for Highcharts server side rendering on Ubuntu
#
# Changes:       This script will:
#                -Install and setup Highcharts export server
#                -More info @ http://bit.ly/1oBc1oG
#
# Prerequisites:
#                -This script assumes a 64bit architecture
#                -This script assumes Java7 is already installed in the system
#                 uncomment 'sudo apt-get install openjdk-7-jdk -y' if required
#
###############################################################################


#config
export PHANTOM_NAME=phantomjs-1.9.7-linux-x86_64
export PHANTOM_FILE=${PHANTOM_NAME}.tar.bz2
export PHANTOM_BINARY=https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOM_FILE}
export HIGHCHARTS_ENDPOINT=https://github.com/tregoning/highcharts.com/trunk/exporting-server/java/highcharts-export
export JAVA_7=java-7-oracle


#Update OS and distros
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get check -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y


#installing PREREQUISITES
sudo apt-get install maven -y
sudo apt-get install subversion -y
sudo apt-get install tomcat7 -y
#sudo apt-get install openjdk-7-jdk -y

sudo ln -s /usr/lib/jvm/${JAVA_7} /usr/lib/jvm/default-java


#installing and setting up Phantomjs
cd /usr/local/share
sudo wget ${PHANTOM_BINARY}
sudo tar xjf ${PHANTOM_FILE}
sudo rm ${PHANTOM_FILE}
sudo ln -s /usr/local/share/${PHANTOM_NAME}/bin/phantomjs  /usr/bin/phantomjs


#using svn as otherwise will have to checkout the *whole* highcharts project
sudo svn export ${HIGHCHARTS_ENDPOINT}


#setting up TOMCAT
echo '
# Required for TOMCAT
export JAVA_HOME=/usr/lib/jvm/default-java
export CATALINA_HOME=/usr/share/tomcat7' >> ~/.bashrc

#load settings
source ~/.bashrc

#config located here update as needed
#/usr/local/share/highcharts-export/highcharts-export-web/src/main/webapp/WEB-INF/spring/app-convert.properties

#INSTALL THE HIGHCHARTS-EXPORT MODULE
cd /usr/local/share/highcharts-export
sudo mvn install

# BUILDING A .WAR FILE
cd /usr/local/share/highcharts-export/highcharts-export-web
sudo mvn clean package

# moving war file to the correct location
sudo cp /usr/local/share/highcharts-export/highcharts-export-web/target/highcharts-export-web.war /var/lib/tomcat7/webapps

# bounce the server to pick up the changes
sudo service tomcat7 restart

#now the server should be up and running
#http://server:8080/highcharts-export-web/

Highchart export server install script
======================================

Description:   Install script for Highcharts server side rendering on Ubuntu

**Changes:**      This script will:

* Install and setup Highcharts export server
* More info @ http://bit.ly/1oBc1oG

**Prerequisites:**

* This script assumes a 64bit architecture
* This script assumes Java7 is already installed in the system uncomment 'sudo apt-get install openjdk-7-jdk -y' if required

**Notes**:         Update this file:

```
/usr/local/share/highcharts-export/highcharts-export-web/src/main/webapp/WEB-INF/spring/app-convert.properties
```

in order to configure the server (number of Phantom instances, timeouts,etc)

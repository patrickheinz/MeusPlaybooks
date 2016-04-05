#!/bin/bash
#
# Server Status Script
# Author: unknown
# Edited: Patrick Heinz 
# Version 0.2
# Updated: March 31th 2016

CPUTIME=$( ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}' )
CPUCORES=$( cat /proc/cpuinfo | grep -c processor )
UP=$( echo `uptime` | awk '{ print $3 " " $4 }' | sed 's/\,//' )
echo "
System Status
Updated: `date`

- Server Name               = `hostname`
- OS Version                = `cat /etc/redhat-release`
- Load Averages             = `cat /proc/loadavg | awk '{ print $1, $2, $3 }'`
- System Uptime             = `echo $UP`
- CPU Usage (average)       = `echo $CPUTIME / $CPUCORES | bc`%
- Memory free (real)        = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}` Mb
- Memory free (cache)       = `free -m | head -n 3 | tail -n 1 | awk {'print $3'}` Mb
- Swap in use               = `free -m | tail -n 1 | awk {'print $3'}` Mb
- Disk Space Used /         = `df -h / | awk '{ a = $3 } END { print a }'`
- Disk Space Used /home     = `df -h /home | awk '{ a = $3 } END { print a }'`
" > /etc/motd

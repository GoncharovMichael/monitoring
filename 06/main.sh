#!/bin/bash

if [ $# != 0 ] ; then
    echo "error"
else
    sudo goaccess -f ~/m/DO4_LinuxMonitoring_v2.0-1/src/04/*.log --log-format=COMBINED -o index.html

fi

#!/bin/bash
set -e

# /etc/timezone /etc/localtime debian centos
echo Timezone was set to $(cat /etc/timezone)
tz=$(timedatectl list-timezones | grep -i ${1:-America/Los_Angeles})
echo $tz
if [[ -z $tz ]]; then
   echo Timezone not found
   exit 1;
fi

sudo timedatectl set-timezone $tz
echo Timezone _is_ set to $(cat /etc/timezone)
#ls -l /etc/localtime

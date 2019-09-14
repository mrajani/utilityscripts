#!/bin/bash

key=${1:-/awskey_rsa}
keyname=${2:-IAWSKey}
[[ -f ${key} ]] && rm ${key}
# ssh-keygen -t ecdsa -b 521 -N "" -C ${keyname} -f $HOME/.ssh/${key}
ssh-keygen -t rsa -b 2048 -N "" -C ${keyname} -f $HOME/.ssh/${key}

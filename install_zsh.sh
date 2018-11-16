#!/bin/bash

user=${1:-vagrant}

if [[ ( -z ${os} && -z ${dist} ) ]]; then
  if [ -e /etc/os-release ]; then
    . /etc/os-release
    os=$( echo ${ID} | awk '{ print tolower($1) }')
    dist=${VERSION_ID}
  fi
fi
echo "Found ${os} "

if [[ ${os} == "centos" ]]; then
  sudo yum -y install zsh
elif [[ ${os} == "ubuntu" ]]; then
  sudo apt-get -yqq update && sudo apt-get install -y zsh
else
  echo "Cannot identify the OS"
  exit 1;
fi

sudo usermod -s /usr/bin/zsh $(whoami)
curl -L http://install.ohmyz.sh | sh


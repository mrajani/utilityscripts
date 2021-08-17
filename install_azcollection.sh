#!/bin/bash

ansible-galaxy collection install azure.azcollection
wget https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt
pip3 install -r requirements-azure.txt


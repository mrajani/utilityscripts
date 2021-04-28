#!/bin/bash

#---- Script to Generate Self Signed Certs ----#

hostname=`hostname -s`
openssl genrsa -out ${hostname}.key 2048
openssl req -new -key ${hostname}.key -out ${hostname}.csr \
  -extensions v3_ca \
  -subj "/C=US/ST=CA/O=IonoAI/L=San Jose/OU=IonoAI/CN=Universal CA root"
openssl x509 -req -days 90 -in ${hostname}.csr -signkey ${hostname}.key \
  -out ${hostname}.crt

HOSTNAME=`hostname -s`
IP_ADDR=$(hostname -I | cut -d " " -f2)
openssl req -x509 -sha256 -nodes \
  -newkey rsa:4096 -days 90 \
  -keyout ./${HOSTNAME}.key -out ./${HOSTNAME}.crt \
  -subj "/CN=${HOSTNAME}" \
  -extensions san \
  -config <(cat /etc/ssl/openssl.cnf <(echo -e "\n[san]\nsubjectAltName=DNS:${HOSTNAME},IP:$IP_ADDR"))


#!/bin/bash

cat <<EOL | tee /tmp/gnupg.conf
%echo Generating a basic OpenPGP key
Key-Type: RSA
Key-Length: 2048
Subkey-Type: ELG-E
Subkey-Length: 1024
Name-Real: Backup Role
Name-Comment: Gitlab
Name-Email: backup@iono.cloud
Expire-Date: 0
Passphrase: 2-Batteries-Not-Included
# Do a commit here, so that we can later print "done" :-)
%commit
%echo done
EOL

gpg --batch --generate-key /tmp/gnupg.conf
gpg --export --armor backup@iono.cloud

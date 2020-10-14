#!/bin/sh
# copy req files to server on lnx academy
# the ~/.ssh/config has the default user and ssh keys

[[ -z $LAPASSWD ]] && echo "LAPASSWD is not set" && exit
[[ -z $MYHOST ]]   && echo "MYHOST is not set" && exit
[[ -z $DOMAIN ]]   && echo "DOMAIN is not set" && exit
export SSHPASS=${LAPASSWD}

[[ ! -f ~/.ssh/lnxa_rsa ]] && \
   ssh-keygen -t rsa -b 2048 -N "" -C "lnx-academy" -f ~/.ssh/lnxa_rsa


for h in "${MYHOST[@]}"; do 
  server=${h}.${DOMAIN}
  ssh-keygen -f /home/vagrant/.ssh/known_hosts -R $server
  ssh-keyscan ${server} >> $HOME/.ssh/known_hosts

  echo run ssh-copy-id
  sshpass -e ssh-copy-id -i ~/.ssh/lnxa_rsa.pub $server:
  scp ~/.gitconfig ~/.ssh/config ~/.ssh/git_id_ecdsa* \
    ~/.ssh/id_rsa* ~/.ssh/lnxa_rsa* ${server}:.ssh
done


for h in "${MYHOST[@]}"; do 
  server=${h}.${DOMAIN}
  echo set up cloud user for sudo privileges
  sshpass -e echo "$LAPASSWD" | \
    ssh -qt ${server} sudo -S echo "cloud_user ALL=\(ALL\) NOPASSWD:ALL | sudo tee /etc/sudoers.d/cloud_user"
  sshpass -e echo "$LAPASSWD" | \
    ssh -qt ${server} sudo -S echo "ansible ALL=\(ALL\) NOPASSWD:ALL | sudo tee /etc/sudoers.d/ansible"
done

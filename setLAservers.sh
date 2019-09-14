#!/bin/sh
# copy req files to server on lnx academy

[[ -z $LAPASSWD ]] && echo "LAPASSWD is not set" && exit
[[ -z $MYHOST ]]   && echo "MYHOST is not set" && exit
[[ -z $DOMAIN ]]   && echo "DOMAIN is not set" && exit

for server in ${MYHOST}{1..6}c.${DOMAIN}; do 
  ssh-keygen -f /home/vagrant/.ssh/known_hosts -R $server
  ssh-keyscan ${server} >> $HOME/.ssh/known_hosts
done

for server in ${MYHOST}{1..6}c.${DOMAIN}; do 
  echo run ssh-copy-id
  sshpass -p $LAPASSWD ssh-copy-id -i ~/.ssh/lnxa_rsa.pub $server:
done

for server in ${MYHOST}{1..6}c.${DOMAIN}; do 
  scp ~/.gitconfig ~/.ssh/config ~/.ssh/git_id_ecdsa* \
    ~/.ssh/id_rsa* ~/.ssh/lnxa_rsa* ${server}:.ssh
done

for server in ${MYHOST}{1..6}c.${DOMAIN}; do 
    echo set up cloud user for sudo privileges
    sshpass -p $LAPASSWD echo "$LAPASSWD" | ssh -qt ${server} sudo -S cp /etc/sudoers.d/{ssm-agent-users,cloud_user}
    sshpass -p $LAPASSWD echo "$LAPASSWD" | ssh -qt ${server} sudo -S sed -i 's/ssm-user/cloud_user/' /etc/sudoers.d/cloud_user
done

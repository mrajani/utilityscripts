#!/bin/sh
# copy req files to server on lnx academy

[[ -z $LAPASSWD ]] && echo "Password not set" && exit
[[ -z $MYHOST ]] && echo "My Host not set" && exit

for server in ${MYHOST}{1..6}c.mylabserver.com; do 
  ssh-keygen -f /home/vagrant/.ssh/known_hosts -R $server
  ssh-keyscan ${server} >> $HOME/.ssh/known_hosts
done

for server in ${MYHOST}{1..6}c.mylabserver.com; do 
  echo Copying my public key to $server
  sshpass -p $LAPASSWD ssh-copy-id -i ~/.ssh/lnxa_rsa.pub $server
done

for server in ${MYHOST}{1..6}c.mylabserver.com; do 
  echo Copying my public key to $server
  scp ~/.gitconfig ~/.ssh/config ~/.ssh/git_id_ecdsa* \
    ~/.ssh/id_rsa* ~/.ssh/lnxa_rsa* ${server}:
done

for server in ${MYHOST}{1..6}c.mylabserver.com; do 
    sshpass -p $LAPASSWD echo "$LAPASSWD" | ssh -qt ${server} sudo -S cp /etc/sudoers.d/{ssm-agent-users,cloud_user}
    sshpass -p $LAPASSWD echo "$LAPASSWD" | ssh -qt ${server} sudo -S sed -i 's/ssm-user/cloud_user/' /etc/sudoers.d/cloud_user
done

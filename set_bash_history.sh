# ignore common commands
echo export HISTIGNORE=”exit:pwd:rm:cp:cd:ls:clear:history:” >> ~/.bashrc
# ignore duplicate entries
echo export HISTCONTROL=ignoredups >> ~/.bashrc
# echo shopt -s histappend >> ~/.bashrc

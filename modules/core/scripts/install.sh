#!/usr/bin/env bash

CORE_HOSTNAME=${1}
GIT_USERNAME=${2}
GIT_EMAIL=${3}

daedalus apt update

daedalus apt dist-upgrade

daedalus apply sysctl ${DAEDALUS_CONFIG_MODULE_PATH}/res/sysctl.conf
daedalus apply security-limits ${DAEDALUS_CONFIG_MODULE_PATH}/res/security_limits.conf
daedalus apply set-hostname $CORE_HOSTNAME

# generate ssh and add to agent
daedalus ssh keygen git $GIT_EMAIL
daedalus ssh keyadd git

git config --global user.name "$GIT_USERNAME"
git config --global user.email $GIT_EMAIL
git remote add update-ssh $GIT_URL

daedalus sshconfig add StrictHostKeyChecking no
daedalus sshconfig add UserKnownHostsFile /dev/null

daedalus sshconfig add-host github
daedalus sshconfig add-host-field github HostName github.com
daedalus sshconfig add-host-field github User git
daedalus sshconfig add-host-field github IdentityFile ~/.ssh/git

daedalus sshconfig add-host gitlab
daedalus sshconfig add-host-field gitlab HostName gitlab.com
daedalus sshconfig add-host-field gitlab User git
daedalus sshconfig add-host-field gitlab IdentityFile ~/.ssh/git

daedalus ssh keyscan github.com
daedalus ssh keyscan gitlab.com

daedalus ssh keygen id_rsa


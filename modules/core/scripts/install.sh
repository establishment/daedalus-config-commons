#!/usr/bin/env bash

CORE_HOSTNAME=${1}
GIT_USERNAME=${2}
GIT_EMAIL=${3}
GIT_URL=${4}

ULIMIT_HARD=${5}
ULIMIT_SOFT=${6}
ULIMIT_SYSTEMD=${7}

daedalus apt update

daedalus apt dist-upgrade

daedalus template set ULIMIT_HARD "${ULIMIT_HARD}"
daedalus template set ULIMIT_SOFT "${ULIMIT_SOFT}"
daedalus template set ULIMIT_SYSTEMD "${ULIMIT_SYSTEMD}"
daedalus tempalte render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/sysctl.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/sysctl.conf"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/security_limits.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/security_limits.conf"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/systemd.conf" "${DAEDALUS_FULL_STATE_MODULE_PATH}/systemd.conf"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/pam-common" "${DAEDALUS_FULL_STATE_MODULE_PATH}/pam-common"
daedalus template render-to "${DAEDALUS_CONFIG_MODULE_PATH}/res/pam-common-noninteractive" "${DAEDALUS_FULL_STATE_MODULE_PATH}/pam-common-noninteractive"

daedalus apply sysctl "${DAEDALUS_FULL_STATE_MODULE_PATH}/sysctl.conf"
daedalus apply security-limits "${DAEDALUS_FULL_STATE_MODULE_PATH}/security_limits.conf"
daedalus apply systemd "${DAEDALUS_FULL_STATE_MODULE_PATH}/systemd.conf"
daedalus apply pam-common "${DAEDALUS_FULL_STATE_MODULE_PATH}/pam-common"
daedalus apply pam-common-noninteractive "${DAEDALUS_FULL_STATE_MODULE_PATH}/pam-common-noninteractive"
daedalus apply set-hostname "${CORE_HOSTNAME}"

# generate ssh and add to agent
daedalus ssh keygen git "${GIT_EMAIL}"
daedalus ssh keyadd git

git config --global user.name "${GIT_USERNAME}"
git config --global user.email "${GIT_EMAIL}"
git remote add update-ssh "${GIT_URL}"

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


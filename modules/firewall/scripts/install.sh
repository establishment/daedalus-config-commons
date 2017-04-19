#!/usr/bin/env bash

daedalus apt install fail2ban

daedalus apt install ufw

# Set the default policy
ufw default deny incoming
ufw default allow outgoing

# Exceptions to default policy
ufw allow 22            # SSH
ufw allow 80            # HTTP
ufw allow 443           # HTTPS
ufw allow 873           # Rsync

# Enable firewall
ufw --force enable


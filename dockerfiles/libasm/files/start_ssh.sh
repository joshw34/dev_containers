#!/bin/bash
set -e

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

if [ ! -d /root/.ssh ]; then
    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys
fi

mkdir -p /run/sshd

exec /usr/sbin/sshd -D

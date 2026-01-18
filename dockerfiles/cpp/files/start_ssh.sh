#!/bin/bash
set -e

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

if [ -d /root/.ssh ]; then
    mkdir -p /root/.ssh-writable
    cat /root/.ssh/*.pub > /root/.ssh-writable/authorized_keys 2>/dev/null
    chmod 700 /root/.ssh-writable
    chmod 600 /root/.ssh-writable/authorized_keys
fi

mkdir -p /run/sshd

exec /usr/sbin/sshd -D


#!/bin/bash

# Check which service exists
if systemctl list-unit-files | grep -q "sshd.service"; then
    SERVICE="sshd"
elif systemctl list-unit-files | grep -q "ssh.service"; then
    SERVICE="ssh"
else
    echo "FAILED"
    exit 1
fi

# Machine-readable check
if systemctl is-active --quiet "$SERVICE"; then
    echo "OK"
else
    echo "FAILED"
fi

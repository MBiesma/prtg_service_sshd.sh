#!/bin/bash

# Check which service exists (leading spaces in output → therefore grep without ^)
if systemctl list-unit-files | grep -q "sshd.service"; then
    SERVICE="sshd"
elif systemctl list-unit-files | grep -q "ssh.service"; then
    SERVICE="ssh"
else
    echo "FAILED"
    exit 1
fi

# Retrieve service status
status_line=$(systemctl status "$SERVICE" 2>/dev/null | grep "Active:")

# Check for active (running)
if echo "$status_line" | grep -q "active (running)"; then
    echo "OK"
else
    echo "FAILED"
fi

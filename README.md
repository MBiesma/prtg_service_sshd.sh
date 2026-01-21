
# SSH/SSHD Service Check Script

This script is designed to be used with monitoring systems such as PRTG to verify whether the SSH service is running on a Linux machine. It automatically detects whether the system uses `sshd.service` (common on older distributions) or `ssh.service` (as used on Ubuntu 24.04 and newer).

## Features
- Automatically detects whether the system uses `sshd` or `ssh` as its SSH service.
- Works even when the SSH service is disabled but present (e.g., socket-activated services).
- Returns `OK` if the service is active and running, otherwise `FAILED`.

## How It Works
1. The script checks installed systemd unit files to determine whether the system provides `sshd.service` or `ssh.service`.
2. Once detected, it queries the service status using `systemctl`.
3. If the output contains `active (running)`, the script returns `OK`; otherwise, it returns `FAILED`.

## Usage
Place the script in the following directory on a PRTG probe device:
```
/var/prtg/scripts/
```

Make the script executable:
```bash
chmod +x prtg_service_sshd.sh
```

Run it manually to test:
```bash
./prtg_service_sshd.sh
```

Expected output:
- `OK` → The SSH service is running.
- `FAILED` → The SSH service is not running or not found.

## Script
```bash
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
```

## Requirements
- Linux system using systemd
- Bash shell
- Permissions to execute systemctl commands

## License
This script may be used, modified, and distributed freely.

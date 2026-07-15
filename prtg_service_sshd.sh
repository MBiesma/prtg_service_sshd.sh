#!/bin/bash
# -----------------------------------------------------------------------------
# Script: prtg_service_sshd.sh
# Purpose: Check whether the SSH service is active (supports ssh.service or sshd.service).
# Output: Prints ONLY "OK" or "FAILED" for machine-readability, e.g. PRTG/SNMP.
# Version: 1.4
# Author: © Mark Biesma
# Notes:
#   - Checks both common SSH service names directly.
#   - Avoids unreliable unit-file detection.
#   - Suppresses stderr to keep output clean for monitoring systems.
# -----------------------------------------------------------------------------

set -euo pipefail

# Ensure systemctl does not use a pager.
export SYSTEMD_PAGER=cat
export SYSTEMD_LESS=

# Check whether either SSH service name is active.
if systemctl is-active --quiet ssh.service 2>/dev/null || \
   systemctl is-active --quiet sshd.service 2>/dev/null; then
    echo "OK"
    exit 0
else
    echo "FAILED"
    exit 1
fi

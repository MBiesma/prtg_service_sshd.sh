#!/bin/bash
# -----------------------------------------------------------------------------
# Script: prtg_service_sshd.sh
# Purpose: Check whether the SSH service is active (supports sshd or ssh).
# Output: Prints ONLY "OK" or "FAILED" for machine-readability (e.g., SNMP).
# Version: 1.3
# Author: © Mark Biesma
# Notes:
#   - Disables systemctl pager to avoid "Failed to print table: Broken pipe".
#   - Avoids pipes for unit detection; checks units directly.
#   - Suppresses stderr to keep output clean for monitoring systems.
# -----------------------------------------------------------------------------

set -euo pipefail

# Ensure systemctl does not use a pager (prevents broken pipe warnings).
export SYSTEMD_PAGER=cat
export SYSTEMD_LESS=

SERVICE=""

# Detect which unit file exists (no pipes, no pager).
if systemctl list-unit-files --no-pager sshd.service >/dev/null 2>&1; then
    SERVICE="sshd"
elif systemctl list-unit-files --no-pager ssh.service >/dev/null 2>&1; then
    SERVICE="ssh"
else
    echo "FAILED"
    exit 1
fi

# Machine-readable status check: only output OK or FAILED.
if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
    echo "OK"
else
    echo "FAILED"
fi

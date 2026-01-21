
#!/bin/bash

# Bepaal welke service bestaat: sshd of ssh
if systemctl list-units --type=service | grep -q "^sshd.service"; then
    SERVICE="sshd"
elif systemctl list-units --type=service | grep -q "^ssh.service"; then
    SERVICE="ssh"
else
    echo "FAILED: geen ssh/sshd service gevonden"
    exit 1
fi

# Haal statusregel op
status_line=$(systemctl status "$SERVICE" 2>/dev/null | grep "Active:")

# Controleer of de service actief is
if echo "$status_line" | grep -q "active (running)"; then
    echo "OK"
else
    echo "FAILED"
fi

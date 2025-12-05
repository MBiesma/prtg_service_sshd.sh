# SSH Service Status Check Script

**Version:** 1.0
**Author:** Your Name
**Date:** 2025-12-05

---

## Description

This simple Bash script checks the status of the SSH service (`sshd`) on a Linux system. It:

* Uses `systemctl` to get the current status of `sshd`
* Checks if the service is `active (running)`
* Prints `OK` if the service is running
* Prints `FAILED` if the service is not running

---

## Installation

1. Save the script, for example:

```bash
sudo nano /opt/check-ssh.sh
```

Paste the script content and save.

2. Make the script executable:

```bash
sudo chmod +x /opt/check-ssh.sh
```

---

## Usage

Run the script:

```bash
sudo /opt/check-ssh.sh
```

Output will be either:

```
OK
```

or

```
FAILED
```

---

## Notes

* The script must be run with sufficient privileges to query the SSH service.
* Works on Linux systems using `systemd`.

---

## License

This script is free to use and modify.

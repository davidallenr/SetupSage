# Ubuntu Setup Guide

This guide provides a quick setup script for new Ubuntu instances. Follow the steps below to update, upgrade, create necessary directories, install `nfs-common`, and mount NFS shares.

## 1. Setup Script

Ensure you have the `resources>setup_ubuntu.sh` script, which includes the necessary commands. The script performs the following actions:

- Updates and upgrades the system packages.
- Creates `/mnt/tv` and `/mnt/movies` directories.
- Installs `nfs-common`.
- Adds NFS mount entries to `/etc/fstab`.
- Mounts all filesystems.

## 2. Running the Setup Script

To execute the script, use the following commands:

```bash
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

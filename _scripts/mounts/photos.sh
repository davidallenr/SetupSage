#!/bin/bash
# Create photos directories
sudo mkdir -p /mnt/photos

# Check if nfs-common is already installed
if ! dpkg -l | grep -qw nfs-common; then
    echo "nfs-common not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y nfs-common
else
    echo "nfs-common is already installed."
fi

# Add entries to /etc/fstab
echo "192.168.10.11:/mnt/media_server/media/photos /mnt/photos nfs defaults,user,exec 0 0" | sudo tee -a /etc/fstab

# Mount everything
sudo mount -a

#!/bin/bash
# Create SD directories
sudo mkdir -p /mnt/tv
sudo mkdir -p /mnt/movies

# Create 4k directories
sudo mkdir -p /mnt/tv_4k
sudo mkdir -p /mnt/movies_4k


# Check if nfs-common is already installed
if ! dpkg -l | grep -qw nfs-common; then
    echo "nfs-common not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y nfs-common
else
    echo "nfs-common is already installed."
fi

# Add entries to /etc/fstab
echo "192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0" | sudo tee -a /etc/fstab
echo "192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0" | sudo tee -a /etc/fstab

# 4k mounts
echo "192.168.10.11:/mnt/media_server/media/movies_4k /mnt/movies_4k nfs defaults,user,exec 0 0" | sudo tee -a /etc/fstab
echo "192.168.10.11:/mnt/media_server/media/tv_4k /mnt/tv_4k nfs defaults,user,exec 0 0" | sudo tee -a /etc/fstab

# Mount everything
sudo mount -a

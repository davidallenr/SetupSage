#!/bin/bash

# Update and install required packages
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add current user to the Docker group to run Docker commands without sudo
sudo usermod -aG docker $USER

# Define Docker Compose version
DOCKER_COMPOSE_VERSION=v2.24.5

# Download Docker Compose and install it as a Docker plugin
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose

# Make Docker Compose executable
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Add Docker Compose directory to user's PATH
echo 'export PATH="/usr/local/lib/docker/cli-plugins:$PATH"' >> ~/.bashrc

# Print Docker and Docker Compose versions to verify installation
echo "Docker and Docker Compose versions:"
docker --version
docker compose version

echo "Installation complete. You may need to log out and back in for group changes to take effect."

## Setting Up Docker and Docker Compose on Ubuntu

### Introduction

This guide covers the installation of Docker and Docker Compose on Ubuntu, enabling you to deploy containerized applications.

### Installing Docker

1. **Install required packages**:

   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
   ```

2. **Add Docker’s official GPG key**:

   ```bash
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```

3. **Set up the Docker repository**:

   ```bash
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   ```

4. **Install Docker Engine**:

   ```bash
   sudo apt update
   sudo apt install docker-ce docker-ce-cli containerd.io -y
   ```

5. **Manage Docker as a non-root user**:
   ```bash
   sudo usermod -aG docker ${USER}
   ```
   Note: Log out and back in for this to take effect, or use `newgrp docker` for immediate effect in the current session.

### Installing Docker Compose (v2)

Docker Compose v2 is installed as a Docker plugin.

1. **Check the latest release of Docker Compose v2**:
   Visit the [Docker Compose GitHub releases page](https://github.com/docker/compose/releases) to find the latest version.

2. **Download and install Docker Compose v2**:
   Replace `v2.x.x` with the latest version you found on the GitHub releases page.

   ```bash
   DOCKER_COMPOSE_VERSION=v2.x.x
   sudo mkdir -p /usr/local/lib/docker/cli-plugins
   sudo curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose

   ```

3. **Make Docker Compose executable**:

   ```bash
   sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
   ```

4. **Verify the installation**:
   ```bash
   docker compose version
   ```

Make sure to replace `v2.x.x` with the actual version number of Docker Compose you wish to install. This ensures you're using the most up-to-date version.

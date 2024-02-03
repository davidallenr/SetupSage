# Setting Up SABnzbd, Radarr, Sonarr, and Overseerr in Docker with TrueNAS

This guide will take you through the setup of Radarr, Sonarr, SABnzbd, and Overseerr in Docker on a VM while accessing mounts from a TrueNAS server.

## Preliminary Steps:

1. **NFS Shares**: Ensure the VM has NFS shares from the TrueNAS server mounted. The IP address used below is an example. Replace '192.168.10.11' with your TrueNAS server's actual IP:

```bash
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0
192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0
```

2. **Directories for SABnzbd**: Create directories for SABnzbd's incomplete and complete downloads:

```bash
mkdir -p /path/to/sabnzbd/incomplete
mkdir -p /path/to/sabnzbd/complete
```

## Docker Compose Configuration:

Below is a suggested `docker-compose.yml` file configuration:

```yaml
version: "3.9"

services:
  radarr:
    image: linuxserver/radarr:latest
    container_name: radarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - /mnt/movies:/movies
      - ~/media-stack/radarr:/config
      - ~/media-stack/sabnzbd/downloads:/downloads
    ports:
      - "7878:7878"
    restart: unless-stopped

  sonarr:
    image: linuxserver/sonarr:latest
    container_name: sonarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - /mnt/tv:/tv
      - ~/media-stack/sonarr:/config
      - ~/media-stack/sabnzbd/downloads:/downloads
    ports:
      - "8989:8989"
    restart: unless-stopped

  sabnzbd:
    image: linuxserver/sabnzbd:latest
    container_name: sabnzbd
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ~/media-stack/sabnzbd:/config
      - ~/media-stack/sabnzbd/downloads:/downloads
    ports:
      - "8080:8080"
    restart: unless-stopped

  overseerr:
    image: sctx/overseerr:latest
    container_name: overseerr
    environment:
      - LOG_LEVEL=debug
      - TZ=America/New_York
      - PORT=5055
    volumes:
      - ~/media-stack/overseerr:/app/config
    ports:
      - "5055:5055"
    restart: unless-stopped
```

### Setup Process:

1. **Start the Containers**:

```bash
docker-compose up -d
```

2. **Access the Web Interfaces**:

   - SABnzbd: `http://<vm-ip>:8080`
   - Radarr: `http://<vm-ip>:7878`
   - Sonarr: `http://<vm-ip>:8989`
   - Overseerr: `http://<vm-ip>:5055`

3. **Service Configuration**:
   - **SABnzbd**: Configure the incomplete and complete directories to `/incomplete-downloads` and `/complete-downloads`.
   - **Radarr** and **Sonarr**: Set them up to monitor the `/downloads` directory and to move/rename files to `/movies` and `/tv`.

**Note**: Always adjust paths based on your actual directory structure.

## Docker Services Setup on an Ubuntu VM:

1. **Install Docker**:

```bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
```

2. **Install Docker-Compose**:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

3. **Start Docker and Enable at Boot**:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

4. **Add User to Docker Group**:

```bash
sudo usermod -aG docker ${USER}
```

You might need to log out and back in for the group changes to take effect.

5. **Set up Docker Compose File**:

Make a directory named `media-stack` and then navigate into it:

```bash
mkdir ~/media-stack
cd ~/media-stack
nano docker-compose.yml
```

Paste in the `docker-compose.yml` content.

6. **Create Directories for Services**:

```bash
mkdir -p ~/media-stack/sabnzbd ~/media-stack/radarr ~/media-stack/sonarr ~/media-stack/overseerr
```

7. **Start the Services**:

Navigate to your `docker-compose.yml` file's location and initiate the services:

```bash
cd ~/media-stack
docker-compose up -d
```

Services should now be accessible at:

- Radarr: `http://your-vm-ip:7878`
- Sonarr: `http://your-vm-ip:8989`
- SABnzbd: `http://your-vm-ip:8080`
- Overseerr: `http://your-vm-ip:5055`

8. **Configuration**:
   - **SABnzbd**: Start the web interface setup wizard.
   - **Sonarr & Radarr**: Link to your movie and TV series directories and incorporate SABnzbd as a downloader.
   - **Overseerr**: Navigate through the web interface to set up services and user permissions.

**Tip**: Make sure to map the config folder in Sonarr and Radarr correctly, e.g., `/config/Downloads/` to `/downloads/`.

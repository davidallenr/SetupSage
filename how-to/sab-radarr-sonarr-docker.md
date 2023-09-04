Setting up Radarr, Sonarr, and SABnzbd together in Docker on a VM while accessing a TrueNAS server's mounts is a common and efficient setup. Here's how you can achieve this:

### Preliminary Steps:

1. **Ensure NFS Shares are Accessible**: Make sure the VM has the NFS shares from the TrueNAS server mounted. This would typically look something like:

```bash
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0
192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0
```

2. **Create Directories for SABnzbd**:

- Create directories for SABnzbd's incomplete and complete downloads:

```bash
mkdir -p /path/to/sabnzbd/incomplete
mkdir -p /path/to/sabnzbd/complete
```

### Docker Compose Configuration:

Here's a basic example of what your `docker-compose.yml` file could look like:

```yaml
version: "3.9"

services:
  sabnzbd:
    image: linuxserver/sabnzbd
    container_name: sabnzbd
    environment:
      - PUID=1000
      - PGID=1000
      - TZ="America/New_York"
    volumes:
      - /path/to/sabnzbd:/config
      - /path/to/sabnzbd/incomplete:/incomplete-downloads
      - /path/to/sabnzbd/complete:/complete-downloads
    ports:
      - 8080:8080
      - 9090:9090

  radarr:
    image: linuxserver/radarr
    container_name: radarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ="America/New_York"
    volumes:
      - /path/to/radarr/config:/config
      - /mnt/movies:/movies
      - /path/to/sabnzbd/complete:/downloads
    ports:
      - 7878:7878

  sonarr:
    image: linuxserver/sonarr
    container_name: sonarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ="America/New_York"
    volumes:
      - /path/to/sonarr/config:/config
      - /mnt/tv:/tv
      - /path/to/sabnzbd/complete:/downloads
    ports:
      - 8989:8989

  overseerr:
    image: sctx/overseerr:latest
    container_name: overseerr
    environment:
      - LOG_LEVEL=debug
      - TZ="America/New_York"
      - PORT=5055
    ports:
      - 5055:5055
    volumes:
      - /path/to/overseerr/config:/app/config
    restart: unless-stopped
```

**Key Things to Note**:

- **Volumes**: For Radarr and Sonarr, you've mounted the complete download directory from SABnzbd. This allows these applications to monitor the directory and handle the files as they're downloaded.
- **Environment Variables**: You've set the `PUID` and `PGID` to ensure file permissions are correctly handled across the containers.
- **Port Mappings**: Each application has a specific port. Ensure no conflicts with other services.

### Setup Process:

1. Start the containers:

   ```bash
   docker-compose up -d
   ```

2. Access the web interfaces for each application:

   - SABnzbd: `http://<vm-ip>:8080`
   - Radarr: `http://<vm-ip>:7878`
   - Sonarr: `http://<vm-ip>:8989`

3. Configure each service:
   - In SABnzbd, set the incomplete and complete directories to `/incomplete-downloads` and `/complete-downloads`, respectively.
   - In Radarr and Sonarr, you can configure them to monitor the `/downloads` directory and move/rename the files to the `/movies` and `/tv` directories, respectively.

## Remember to adjust file and folder paths based on your actual directory structure.

---

These steps assume that you installed nfs-common and mounted the tv/movies directores to `/mnt/movies` and `/mnt/tv`. Username is `media`.

Steps to set up Docker services on your fresh Ubuntu VM.

**1. Install Docker:**

First, install Docker. Follow the steps below:

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
```

**2. Install Docker-Compose:**

To manage multiple containers as a single service, you'll need `docker-compose`.

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

**3. Start Docker and enable it to start at boot:**

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

**4. Add your user to the Docker group:**

This step is essential to avoid needing `sudo` every time you use Docker.

```bash
sudo usermod -aG docker ${USER}
```

You need to logout and back in for the group changes to take effect.

**5. Set up Docker Compose file:**

A docker-compose file which you can save as `docker-compose.yml` in a directory. Create a new directory named `media-stack`:

```bash
mkdir ~/media-stack
cd ~/media-stack
nano docker-compose.yml
```

Now paste in the `docker-compose.yml`

**6. Create the necessary directories:**

The services need directories to persist configuration and data. Let's create these directories.

```bash
mkdir -p ~/media-stack/sabnzbd ~/media-stack/radarr ~/media-stack/sonarr ~/media-stack/overseerr
```

**7. Start the services:**

Navigate to where you have the `docker-compose.yml` file and start the services.

```bash
cd ~/media-stack
docker-compose up -d
```

Now the services should be up and running:

- Radarr will be accessible at `http://your-vm-ip:7878`
- Sonarr will be accessible at `http://your-vm-ip:8989`
- SABnzbd will be accessible at `http://your-vm-ip:8080`
- Overseerr will be accessible at `http://your-vm-ip:5055`

**8. Configuration:**

- **SABnzbd**: Once you access the web interface, you will be greeted by a setup wizard. Follow the instructions to set up your Usenet provider and other preferences.
- **Sonarr & Radarr**: Access their respective interfaces and point them to your movie and TV series directories. You'll also need to add SABnzbd as a downloader.

- **Overseerr**: Once you're in the web interface, you can set up the services and user permissions.

That's the basic setup. You can further optimize and secure each service according to your needs.

## Remember to map the config folder in sonarr and radarr respectively. IE `/config/Downloads/` to `/downloads/`

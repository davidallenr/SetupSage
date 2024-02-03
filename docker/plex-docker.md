# Setting Up Plex in Docker

In this guide, we'll set up Plex in a Docker container on a VM, ensuring it can access the necessary mounts from the VM (`/mnt/movies` and `/mnt/tv` and `/mnt/movies_4k` and `/mnt/tv_4k`).

## Prerequisites

Ensure Docker and Docker Compose are installed on your system.

## Configuration

1. **Directory Setup**:

   Create the necessary directories for Plex's configuration files and media storage.

   ```bash
   mkdir -p ~/docker/appdata/plex

   ```

2. **Docker Compose Configuration**:

Save the following configuration to a file named `docker-compose.yml`:

```yaml
version: "3.9"

services:
  plex:
    image: plexinc/pms-docker:plexpass
    container_name: plex
    ports:
      - "32400:32400/tcp"
      - "3005:3005/tcp"
      - "8324:8324/tcp"
      - "32469:32469/tcp"
      - "1900:1900/udp"
      - "32410:32410/udp"
      - "32412:32412/udp"
      - "32413:32413/udp"
      - "32414:32414/udp"
    volumes:
      - ./appdata/plex:/config
      - /mnt/movies:/movies
      - /mnt/movies_4k:/movies_4k
      - /mnt/tv:/tv
      - /mnt/tv_4k:/tv_4k
      - /dev/shm:/transcode
    environment:
      - TZ=America/New_York
      - HOSTNAME=dockerPlex
      - PLEX_CLAIM=your_claim_token
      - ADVERTISE_IP=http://192.168.10.12:32400/
```

### Key Points:

- **Image**: The `image` field specifies `plexinc/pms-docker:plexpass`, which is the Docker image for Plex Media Server with Plex Pass support. This image gets updates faster than the public release versions and includes new features and fixes.
- **Volumes**: Make sure the paths for volumes (`/config`, `/movies`, `/tv`, and `/transcode`) correctly point to the desired locations on your host for Plex configuration, media files, and transcoding cache, respectively.
- **Environment Variables**:
  - `TZ` sets the timezone for your Plex server.
  - `HOSTNAME` is an optional environment variable that can be set to the desired hostname for the Plex server.
  - `PLEX_CLAIM` is used for claiming the server automatically with your Plex account. Obtain a claim token from [https://www.plex.tv/claim](https://www.plex.tv/claim).
  - `ADVERTISE_IP` helps Plex in Docker announce itself on your network. Replace `192.168.10.12` with the IP address of your Docker host.

Remember, using the Plex Pass version requires an active Plex Pass subscription. The `PLEX_CLAIM` token is particularly important for initial setup, as it associates your new Plex server instance with your Plex account automatically.

3. **Starting Plex**:

Navigate to the directory containing your `docker-compose.yml` and initiate the Plex container:

```bash
docker-compose up -d
```

1. **Accessing Plex**:

With Plex running, open a web browser and navigate to `http://{server_ip}:32400/web`. The Plex setup wizard should appear, allowing you to configure your server.

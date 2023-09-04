# Setting Up Plex in Docker with TrueNAS

In this guide, we'll set up Plex in a Docker container on a VM, ensuring it can access the necessary mounts from the VM (`/mnt/movies` and `/mnt/tv`).

## Prerequisites:

1. **Install Docker and Docker-Compose**:
   Make sure you have both `docker` and `docker-compose` installed.

2. **Add User to Docker Group**:

```bash
sudo usermod -aG docker $USER
```

After executing this command, either log out and back in or restart your session to ensure group changes are applied.

## Configuration:

1. **Directory Setup**:

```bash
mkdir -p /home/media/docker/appdata/plex
mkdir -p /media/storage/media
```

2. **Docker Compose Configuration**:

Save the following configuration to a file named `docker-compose.yml`:

```yaml
version: "3.9"

services:
  plex:
    image: plexinc/pms-docker:public
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
      - /home/media/docker/appdata/plex:/config
      - /mnt/movies:/mnt/movies
      - /mnt/tv:/mnt/tv
      - /dev/shm:/transcode
    environment:
      - TZ=America/New_York
      - HOSTNAME=dockerPlex
      - PLEX_CLAIM=your_claim_token
      - PLEX_UID=1000
      - PLEX_GID=1000
      - ADVERTISE_IP=http://192.168.10.11:32400/
```

3. **NFS Share Mounting**:

Add the following lines to `/etc/fstab`:

```
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0
192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0
```

After adding, execute:

```bash
sudo mount -a
```

This ensures the mounts are available on the host system (Ubuntu VM). With these volume bindings (`/mnt/movies:/mnt/movies` and `/mnt/tv:/mnt/tv`) specified in the docker-compose file, the Plex container can access the NFS mounts.

4. **Starting Plex**:

Navigate to the directory containing your `docker-compose.yml` and initiate the Plex container:

```bash
docker-compose up -d
```

Ensure all environment variables (`$DOCKERDIR`, `$DATADIR`, `$TZ`, `$PLEX_CLAIM`, `$PUID`, and `$PGID`) are defined. If you're using an `.env` file, it should reside in the same directory as your docker-compose file.

5. **Accessing Plex**:

With Plex running, open a web browser and navigate to `http://192.168.10.11:32400/web`. The Plex setup wizard should appear, allowing you to configure your server.

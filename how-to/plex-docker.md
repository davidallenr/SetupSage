Plex container needs to be able to access (`/mnt/movies` and `/mnt/tv`) from the VM.

Here's how you can set this up

1. **Ensure Prerequisites**:

   Ensure you have `docker` and `docker-compose` installed. Make sure your user is part of the `docker` group:

   ```bash
   sudo usermod -aG docker $USER
   ```

   Then, either log out and log back in or restart your session to apply the group changes.

2. **Setup Directories**:

   Before starting with Docker Compose, ensure your directories are set up correctly:

   ```bash
   mkdir -p /home/media/docker/appdata/plex
   mkdir -p /media/storage/media
   ```

3. **Docker Compose File**:

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

Save this to a file named `docker-compose.yml`.

4. **Mount NFS Shares**:

Before the Plex container can access the NFS mounts, you need to ensure these mounts are available on your Ubuntu VM. Based on the lines you provided, you can add them to your `/etc/fstab`:

```
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0
192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0
```

Then, mount them:

```bash
sudo mount -a
```

Once these are mounted on the host system (your Ubuntu VM), the Plex container should be able to access the mounts through the volume bindings in the docker-compose file (`/mnt/movies:/mnt/movies` and `/mnt/tv:/mnt/tv`).

5. **Start Plex**:

Navigate to the directory containing your docker-compose file and run:

```bash
docker-compose up -d
```

Now, your Plex container should be up and running with access to the NFS mounts. Make sure you've defined all the environment variables (`$DOCKERDIR`, `$DATADIR`, `$TZ`, `$PLEX_CLAIM`, `$PUID`, and `$PGID`) either in your shell or in an `.env` file in the same directory as your docker-compose file.

6. **Access Plex**:

   Once Plex is running, navigate to `http://192.168.10.11:32400/web` in your web browser. You should be able to access the Plex setup wizard and start configuring your server.

Following this fresh setup should help you get Plex up and running without any previous configuration or data.

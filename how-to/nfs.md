**1. Check if NFS client utilities are installed:**

You need to have the necessary packages to support NFS. You can check if they're installed and if not, install them. For different distributions, the commands may vary:

- **Ubuntu/Debian**:
  ```bash
  sudo apt update
  sudo apt install nfs-common
  ```

- **CentOS/Red Hat/Fedora**:
  ```bash
  sudo yum install nfs-utils
  ```

- **Arch Linux**:
  ```bash
  sudo pacman -S nfs-utils
  ```

**2. Create a Mount Point:**

You need a directory to mount your NFS share to. Let's say you want to mount it to `/mnt/myshare`:

```bash
sudo mkdir -p /mnt/tv
sudo mkdir -p /mnt/movies
```

**3. Mount the NFS Share:**

You can manually mount the NFS share using the following command:

```bash
sudo mount -t nfs 192.168.10.11:/mnt/media_server/media/movies /mnt/movies

sudo mount -t nfs 192.168.10.11:/mnt/media_server/media/tv /mnt/tv
```

Replace `your_truenas_IP` with the IP address of your TrueNAS server and `/path_to_share_on_truenas` with the path to your NFS share on the TrueNAS system.

**4. Automatically Mount on Boot:**

If you want the NFS share to be mounted automatically on boot, you'll need to edit the `/etc/fstab` file.

```bash
sudo nano /etc/fstab
```

Add the following line at the end of the file:

```
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0

192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0

```

Save and close the file. 

**5. Test the Configuration:**

To ensure that there's no issue with the fstab entry, test it with:

```bash
sudo mount -a
```

If there's no error, then you've successfully added the NFS share to your fstab.

Ensure you've set the proper permissions on the NFS share from TrueNAS so that the user can read (and possibly write, depending on your use case) to the share. 

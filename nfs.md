# Setting Up NFS Client and Mounting NFS Shares

This guide demonstrates how to set up the NFS client on various Linux distributions and mount NFS shares from a TrueNAS server.

> **Note:** In the examples below, `192.168.10.11` is used as a sample IP address for the TrueNAS server. Ensure you replace this with the actual IP address of your TrueNAS server when following the guide.

## 1. **Install NFS Client Utilities**

Ensure you have the necessary packages to support NFS. Installation varies based on your distribution:

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

## 2. **Create Mount Points**

Determine where you want to mount your NFS shares. For this guide, we'll use `/mnt/tv` and `/mnt/movies`:

```bash
sudo mkdir -p /mnt/tv
sudo mkdir -p /mnt/movies
```

## 3. **Manually Mount NFS Shares**

To manually mount the NFS share, use the following commands:

```bash
sudo mount -t nfs 192.168.10.11:/mnt/media_server/media/movies /mnt/movies
sudo mount -t nfs 192.168.10.11:/mnt/media_server/media/tv /mnt/tv
```

Ensure you adjust the share path if it differs from the example.

## 4. **Mount NFS Shares Automatically at Boot**

To mount NFS shares automatically on boot, you need to modify the `/etc/fstab` file:

```bash
sudo nano /etc/fstab
```

Append these lines to the end of the file:

```
192.168.10.11:/mnt/media_server/media/movies /mnt/movies nfs defaults,user,exec 0 0
192.168.10.11:/mnt/media_server/media/tv /mnt/tv nfs defaults,user,exec 0 0
```

After saving and closing the file, you can proceed to testing.

## 5. **Test the Configuration**

Verify the fstab entry for correctness:

```bash
sudo mount -a
```

If no errors appear, then the NFS share has been successfully added to your fstab. Remember to configure the appropriate permissions on the NFS share from TrueNAS to allow the user to read (and possibly write, based on your needs) to the share.

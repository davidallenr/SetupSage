# Troubleshooting: VM Reporting Low Space

If a specific container is reporting only a few gigabytes of free space, it might be observing the storage space allocated to the Docker container's filesystem instead of the host machine's filesystem. This discrepancy can occur if the container is checking a path not appropriately mapped to an external volume on the host.

## Steps to Troubleshoot:

### 1. Check the Volume Mapping in Docker Compose

Ensure that the path the container uses to save files is correctly mapped to a path on the host in your `docker-compose.yml` file.

```yaml
volumes:
  - ${USERDIR}/docker/appdata/container_name:/config
```

In this configuration, any file the container writes to `/config` inside itself should correspondingly be written to `${USERDIR}/docker/appdata/container_name` on the host.

### 2. Check Disk Space on the Host

On your host machine, use the command:

```bash
df -h
```

This command displays the available disk space, allowing you to match the container's reported space with these values.

### 3. Docker Overlay2 Storage

Docker employs `overlay2` as its storage driver. At times, this can become overloaded, particularly with numerous images, containers, or volumes. To view a summary of Docker's storage usage:

```bash
docker system df
```

If necessary, recover space using:

```bash
docker system prune
```

However, proceed with caution as this will delete unused data, including stopped containers, dangling images, and unused networks.

### 4. Quotas

Ensure that no storage quotas on your system are triggering the limitation.

### 5. Docker Storage Configuration

Docker might have a default storage limit set. Consider checking and potentially expanding Docker's storage if it appears constrained.

### 6. Log Files

Inspect for abnormally extensive log files taking up space. The container or other applications could be producing extensive logs. If these logs aren't mapped to an external volume, they might be using up container space.

After checking the paths, mappings, and the potential issues mentioned above, the cause of the reduced space report should become apparent.

## Extending the Logical Volume:

### Identify the Logical Volume

Use the following command:

```bash
sudo lvdisplay
```

In the output, identify the logical volume (e.g., `/dev/ubuntu-vg/ubuntu-lv`).

### Extend the Logical Volume

With the identified `LV Path`, extend the volume:

```bash
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
```

### Resize the Filesystem

To utilize the expanded space:

```bash
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
```

### Verify the Changes

Inspect the new space on your system with:

```bash
df -h
```

The increased space should now be visible for your root filesystem, and the VM should also accurately reflect the expanded space.

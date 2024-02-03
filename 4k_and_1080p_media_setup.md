# Managing 4K and 1080p Media Content in Sonarr and Radarr

In this guide, we'll cover how to set up and manage both 4K and 1080p content using Sonarr, Radarr, and Plex, ensuring that they don't interfere with each other.

## Introduction

When deploying Sonarr and Radarr in Docker containers, managing different media qualities can become complex. Specifically, there's potential for conflict when dealing with 1080p and 4K content simultaneously.

## Key Considerations

- **Parallel Media Systems:** It's vital to ensure parallel systems for different media qualities don't overwrite or delete each other's content.
- **Performance:** Serving 4K content, especially when transcoding, requires significantly more computing power than 1080p. Be sure your server can handle the demands.

## Setup Steps

### 1. Directory Structure

- Create separate directories for your 4K and 1080p content. Recommended structure:
  - `/mnt/movies_1080p` and `/mnt/tv_1080p`
  - `/mnt/movies_4k` and `/mnt/tv_4k`

This separation ensures that the two systems won't interfere with each other's files.

### 2. Configuration in Sonarr and Radarr

- If you opt for the same directory for both qualities, be aware that Sonarr/Radarr might replace the 1080p version with the 4K one if set to upgrade qualities.

### 3. Handling Duplicate Versions in Media Servers

Media servers like Plex, Emby, or Jellyfin can handle multiple versions of the same content:

- If the versions are in the same directory, they'll usually be detected and labeled appropriately (e.g., "1080p" and "4K").
- If they are in separate directories, ensure both directories are added to the media server's library.

### 4. Plex Specific Configuration

- Create directories in TrueNAS for 4K content:

  - `media/movies_4k`
  - `media/tv_4k`

- Configure the 4K Sonarr and Radarr instances to point to these directories.
- Add the new directories to Plex.
- Plex will automatically choose the highest quality for streaming, but users can manually select the desired version.

**Note:** Transcoding 4K content can be resource-intensive. Ensure your server's resources are up to the task.

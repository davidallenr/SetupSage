# SetupSage Repository

Welcome to the `SetupSage` repository, your comprehensive resource for setting up, configuring, and troubleshooting your media server environment. This repository focuses on Docker deployments, server management, and includes detailed documentation, configuration files, and scripts to assist in creating an efficient setup for media servers and other applications.

## Repository Structure

This repository is organized into several key areas to help you navigate through the setup process:

- **Documentation and Guides**: Includes markdown guides for Docker setups, NFS configurations, server setups, and more. Topics covered include 4K and 1080p media setup, NFS setup, Radarr and Sonarr quality settings, Ubuntu commands, and Ubuntu setup.
- **Docker**: Contains guides and configuration files for Docker container setups, including Plex, SABnzbd, Radarr, and Sonarr.
- **Servers**: Provides setup instructions for web servers, including Nginx.
- **Troubleshooting**: Offers solutions for common issues in virtual machines and Docker environments, such as VM soft lockup and VM reporting low space.
- **Docker Compose Files**: Features Docker Compose files (`Plex-docker-compose.yml`, `Rad-Son-Sab-docker-compose.yml`) for deploying applications.
- **Scripts**: Hosts automation scripts for backup, setup, and maintenance tasks, such as backing up Docker configurations, setting up Docker and Docker Compose on Ubuntu, and managing mounts.

## Using the Scripts

The `_scripts` folder contains several automation scripts designed to streamline your setup and maintenance processes. Key among them is the `setup-moveAllJobs.sh` script, which simplifies the process of organizing and scheduling your backup scripts.

### setup-moveAllJobs.sh

This script automates moving all shell scripts from the `_scripts` directory to a designated `jobs` directory on your machine, making them executable, and scheduling backup jobs in the crontab to run at specific intervals.

**To use the script:**

1. **Navigate to the `_scripts` Folder**: Change your directory to the `_scripts` folder within the `SetupSage` repository.
   ---bash
   cd path/to/SetupSage/\_scripts
   ***
2. **Run the `setup-moveAllJobs.sh` Script**: Execute the script to efficiently organize your backup jobs.
   ---bash
   ./setup-moveAllJobs.sh
   ***
   - The script copies all `.sh` files to the `~/jobs/` directory.
   - It makes all scripts in `~/jobs/` executable.
   - It schedules any `backup-*.sh` scripts in the crontab, ensuring they run sequentially, an hour apart, beginning at 7 AM.

**Important Note**: Before running the script, verify you have the necessary permissions and backup your current crontab to avoid accidental overwrites.

## Getting Started

To effectively use this repository:

1. **Explore the Documentation**: Familiarize yourself with the setup processes and configurations.
2. **Deploy with Docker Compose**: Utilize the provided Docker Compose files for quick application deployment.
3. **Automate Setup and Maintenance**: Use the scripts in the `_scripts` folder to automate various setup and maintenance tasks, enhancing efficiency and reliability.

## Contributing

Your contributions can help improve and expand this repository. Feel free to submit pull requests or create issues for any suggestions, corrections, or additional content you believe would be beneficial.

## License

The contents of this repository are released under the [MIT License](./LICENSE). Refer to the LICENSE file for more details.

_Last updated: [2/9/2024]_

# SetupSage Repository

Welcome to the `SetupSage` repository, your comprehensive resource for setting up, configuring, and troubleshooting your media server environment. This repository focuses on Docker deployments, server management, and includes detailed documentation, configuration files, and scripts to assist in creating an efficient setup for media servers and other applications.

## Repository Structure

This repository is organized into several key areas to help you navigate through the setup process:

- **Documentation and Guides**: Includes markdown guides for Docker setups, NFS configurations, server setups, and more.
- **Docker**: Contains guides and configuration files for Docker container setups.
- **Servers**: Provides setup instructions for web servers, including Nginx.
- **Troubleshooting**: Offers solutions for common issues in virtual machines and Docker environments.
- **Docker Compose Files**: Features Docker Compose files for deploying applications.
- **Scripts**: Hosts automation scripts for backup, setup, and maintenance tasks.

## Using the Scripts

The `_scripts` folder contains several automation scripts designed to streamline your setup and maintenance processes. Here's how to use them:

### setup-moveAllJobs.sh

This script automates the process of moving all shell scripts from the `_scripts` directory to a designated `jobs` directory on your machine, making them executable, and scheduling backup jobs in the crontab to run at specific intervals.

**To use the script:**

1. **Navigate to the `_scripts` Folder**: Change your directory to the `_scripts` folder within the `SetupSage` repository.
   ```bash
   cd path/to/SetupSage/_scripts
   ```

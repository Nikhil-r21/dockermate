# DockerMate v1.0 User Manual

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Getting Started](#getting-started)
4. [Installation Setup](#installation-setup)
5. [Main Menu Overview](#main-menu-overview)
6. [Container Management](#container-management)
7. [Image Management](#image-management)
8. [Network Management](#network-management)
9. [Volume Management](#volume-management)
10. [Container Health Check](#container-health-check)
11. [Debugging Tools](#debugging-tools)
12. [Cleanup Operations](#cleanup-operations)
13. [Error Handling](#error-handling)
14. [Tips and Best Practices](#tips-and-best-practices)

## Introduction

DockerMate v1.0 is a comprehensive Bash script designed to simplify Docker container, image, network, and volume management through an interactive, color-coded terminal interface. The script provides an organized menu system that allows users to perform a wide range of Docker operations without needing to remember complex command-line syntax.

## Prerequisites

- A Linux-based operating system
- Docker installed and properly configured
- Bash shell
- Basic understanding of Docker concepts

## Getting Started

1. Save the script as `dockermate.sh`
2. Make the script executable:
   ```
   chmod +x dockermate.sh
   ```
3. Run the script:
   ```
   ./dockermate.sh
   ```

When you launch DockerMate, the script first checks if Docker is installed on your system. If Docker is not detected, the script will display an error message and exit.

## Installation Setup

To install DockerMate, follow the steps below:
1. Add the DockerMate repository:
   ```
   sudo sh -c 'echo "deb [trusted=yes] https://nikhil-r21.github.io/dockermate/repo/ noble main" > /etc/apt/sources.list.d/dockermate.list'
   ```
2. Import the GPG key:
   ```
   wget -qO - https://nikhil-r21.github.io/dockermate/repo-key.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dockermate.gpg
   ```
3. Update package lists:
   ```
   sudo apt update
   ```
4. Install DockerMate:
   ```
   sudo apt install dockermate
   ```
5. Run DockerMate:
   ```
   sudo dockermate
   ```

## Main Menu Overview

After starting DockerMate, you'll be presented with a color-coded main menu that offers the following options:

1. **Container Management** (Cyan): Manage Docker containers
2. **Image Management** (Blue): Manage Docker images
3. **Network Management** (Green): Manage Docker networks
4. **Volume Management** (Magenta): Manage Docker volumes
5. **Container Health Check** (Light Green): View container health status
6. **Debugging Tools** (Yellow): Access Docker debugging utilities
7. **Cleanup Operations** (Red): Clean up unused Docker resources
0. **Exit** (White): Exit the application

Navigate through the menu by entering the corresponding number and pressing Enter.

## Container Management

The Container Management section allows you to view and manage your Docker containers.

### Features:

#### Individual Container Management
This option lets you select a specific container and perform the following actions:
- Start a stopped container
- Stop a running container
- Restart a container
- Delete a container
- View container logs
- Inspect container details
- Execute commands inside a container

#### Batch Operations
- Start all stopped containers
- Stop all running containers
- Restart all containers
- Delete all containers

### How it works:

1. When you enter Container Management, the script displays a list of available containers with color coding:
   - Green: Running containers
   - Red: Stopped containers
   - Magenta: Containers in other states

2. For individual container management:
   - Select the container by its number
   - Choose from the actions menu
   - The script executes the corresponding Docker command
   - Press any key to continue after the operation completes

3. For batch operations:
   - Select the operation from the menu
   - The script executes the operation on all relevant containers
   - Press any key to continue after the operation completes

## Image Management

The Image Management section allows you to work with Docker images.

### Features:

#### Individual Image Management
- Delete a specific image
- Inspect image details

#### Batch Operations
- Pull new images from Docker Hub
- List dangling (unused) images
- Prune unused images
- Delete all images

### How it works:

1. When you enter Image Management, the script displays a list of available images in cyan.

2. For individual image management:
   - Select the image by its number
   - Choose from the actions menu
   - The script executes the corresponding Docker command

3. For pulling new images:
   - Enter the image name and tag (e.g., ubuntu:latest)
   - The script validates your input to prevent command injection
   - Docker pulls the image

4. For batch operations:
   - Select the operation from the menu
   - For potentially destructive operations, you'll be asked to confirm
   - The script executes the operation

## Network Management

The Network Management section provides tools to manage Docker networks.

### Features:
- Inspect network details
- Delete a network
- Create a new network with a specific driver

### How it works:

1. When you enter Network Management, the script displays a list of available networks in cyan.

2. To inspect a network:
   - Select option 1
   - Enter the network name or ID
   - The script shows detailed information about the network

3. To delete a network:
   - Select option 2
   - Enter the network name or ID to delete
   - The script removes the specified network

4. To create a new network:
   - Select option 3
   - Enter a name for the new network
   - Select a network driver (bridge/overlay/host)
   - The script creates the network with the specified parameters

## Volume Management

The Volume Management section lets you work with Docker volumes.

### Features:
- Inspect volume details
- Delete a volume
- Create a new volume

### How it works:

1. When you enter Volume Management, the script displays a list of available volumes in cyan.

2. To inspect a volume:
   - Select option 1
   - Enter the volume name
   - The script shows detailed information about the volume

3. To delete a volume:
   - Select option 2
   - Enter the volume name to delete
   - The script removes the specified volume

4. To create a new volume:
   - Select option 3
   - Enter a name for the new volume
   - The script creates the volume

## Container Health Check

The Container Health Check feature provides an overview of your Docker system's health.

### Features:
- Docker system information (containers, images, server version)
- Detailed container health status

### How it works:

1. When you select Container Health Check, the script:
   - Displays Docker system information
   - Shows the status of each container with color coding:
     - Green: Healthy (running)
     - Red: Stopped
     - Yellow: Unknown status

2. Press any key to return to the main menu after viewing the information.

## Debugging Tools

The Debugging Tools section provides utilities for troubleshooting Docker issues.

### Features:
- Docker Info: View system-wide Docker information
- Docker Version: Check Docker version details
- Disk Usage: View Docker disk usage statistics
- Filter Logs with Timestamps: View container logs within a specific time range
- Capture Container Events: Monitor real-time Docker events
- Live Container Resource Usage: Monitor container CPU, memory, and network usage
- Detailed Container Logs: View logs with customizable output options

### How it works:

1. When you select Debugging Tools, a menu of debugging options appears.

2. For basic information (options 1-3):
   - Select the desired option
   - The script displays the information
   - Press any key to continue

3. For filtered logs (option 4):
   - Enter the container name
   - Specify start and end times in YYYY-MM-DD HH:MM:SS format
   - The script displays the filtered logs

4. For events monitoring (option 5):
   - The script starts capturing Docker events
   - Press Ctrl+C to stop monitoring

5. For resource monitoring (option 6):
   - The script displays live resource usage statistics
   - Press Ctrl+C to stop monitoring

6. For detailed logs (option 7):
   - Enter the container name
   - Specify how many log lines to display (default: 50)
   - The script shows the logs
   - Press Ctrl+C to stop viewing

## Cleanup Operations

The Cleanup Operations section helps you clean up unused Docker resources.

### Features:
- Prune Stopped Containers: Remove all stopped containers
- Prune Unused Images: Remove dangling images
- Prune Unused Volumes: Remove volumes not attached to any container
- Prune Unused Networks: Remove networks not used by any container
- System Prune: Remove all unused Docker resources (containers, images, networks, and volumes)

### How it works:

1. When you select Cleanup Operations, a menu of cleanup options appears.

2. For each cleanup operation:
   - Select the desired option
   - Confirm the action when prompted (type 'y' or 'yes' to proceed)
   - The script performs the cleanup operation
   - A success or failure message is displayed
   - Press any key to continue

3. The System Prune option (5) is the most comprehensive and removes all unused resources.

## Error Handling

DockerMate includes robust error handling to help you identify and resolve issues.

### Features:
- Command validation to prevent injection attacks
- Error detection for Docker operations
- User-friendly error messages
- Confirmation for potentially destructive operations

### How it works:

1. Input validation:
   - When you enter text input (like image names), the script checks for suspicious patterns
   - If malicious input is detected, an error message appears and the operation is canceled

2. Operation result checking:
   - After executing Docker commands, the script checks if they succeeded
   - Success or failure messages are displayed accordingly

3. Confirmation for destructive operations:
   - Before performing operations that might delete data, the script asks for confirmation
   - You must type 'y' or 'yes' to proceed

## Tips and Best Practices

1. **Regular Cleanup**: Use the Cleanup Operations menu regularly to keep your Docker environment tidy.

2. **Container Health Checks**: Check container health periodically to ensure everything is running properly.

3. **Safe Exit**: Always use the Exit option or Ctrl+C to properly exit the script.

4. **Command Execution**: When executing commands in containers, be cautious about what commands you run.

5. **Batch Operations**: Be careful with batch operations like "Delete All Containers" as they affect all resources.

6. **System Resources**: Use the debugging tools to monitor resource usage if your system seems slow.

7. **Network Management**: Be careful when deleting networks as it might affect container connectivity.

8. **Volume Management**: Remember that deleting volumes permanently removes the data they contain.

# Docker_Management_Tool
Docker Management Tool User Manual

Welcome to the Docker Management Tool. This guide will walk you through the key features and actions available in the tool.

Container Management

Available Actions

Individual Container Management

Enter 1 to access individual container management.

To stop a container, enter 2. The selected container will stop.

To view the logs of a container, enter 5.

For a detailed inspection of the container, enter 6.

Start All Stopped Containers

Enter 2 to start all stopped containers.

Stop All Containers

Enter 3 to stop all containers. The available containers will turn red, indicating they are stopped.

Restart All Containers

Enter 4 to restart all containers.

Image Management

Available Actions

Manage Individual Images

Enter 1 to access individual image management.

To delete an image, enter 1.

To inspect an image, enter 2 to view detailed information about the image.

Check Unused Images

Enter 2 to list unused images. If no unused images are present, a message will indicate this.

Network Management

Available Actions

Inspect a Network

Enter 1 and provide the network ID to view logs.

Create a New Network

Enter 3 to create a new network.

Provide a network name (e.g., "Sample Network").

Select a network driver (e.g., "Bridge").

The new network will be created.

Delete a Network

Enter 2 and provide the network ID to delete the network.

Volume Management

Available Actions

Inspect a Volume

Enter 1 and provide the volume name to view logs.

Create a New Volume

Enter 3 to create a new volume.

Provide a volume name (e.g., "Sample Volume").

The new volume will be created.

Delete a Volume

Enter 2 and provide the volume name to delete the volume.

Container Health Check

Enter 5 to check the health status of all containers. A status report will display the health of each container.

Debugging Tools

Available Actions

Live Container Resource Usage

Enter 3 to view live resource usage for containers.

Exiting the Tool

Enter 0 to exit the tool.

Note

Some actions might not be fully demonstrated in this guide. Feel free to explore all the features of the Docker Management Tool and share your feedback.

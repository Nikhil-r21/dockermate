# Docker Management Tool

Welcome to the **Docker Management Tool**! This command-line utility simplifies the process of managing Docker containers, images, networks, and volumes. Built using shell scripting, it provides a straightforward and interactive interface for both novice and experienced Docker users.

## Features

- **Container Management**
  - View, start, stop, restart, or delete individual containers
  - Start, stop, restart, or delete all containers
  - View logs and inspect container details

- **Image Management**
  - View Docker images and inspect image details
  - List unused images
  - Delete unused or all images

- **Network Management**
  - View Docker networks and inspect network details
  - Create and delete networks

- **Volume Management**
  - View volumes and inspect volume details
  - Create and delete volumes

- **Container Health Monitoring**
  - Display health status of all containers

- **Debugging Tools**
  - Filter logs with timestamps
  - Capture container events
  - Monitor live container resource usage (CPU, memory, etc.)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/docker-management-tool.git
   ```

2. Navigate to the directory:
   ```bash
   cd docker-management-tool
   ```

3. Make the script executable:
   ```bash
   chmod +x docker-tool.sh
   ```

4. Run the script:
   ```bash
   ./docker-tool.sh
   ```

## Usage

### Main Menu
From the main menu, you can select one of the following options:

1. **Container Management**
2. **Image Management**
3. **Network Management**
4. **Volume Management**
5. **Container Health Management**
6. **Debugging Tools**
7. **Exit**

### Exiting
To exit the tool, select option `0` from any menu or press `Ctrl + C`.

## Contribution

We welcome contributions to enhance this tool! Follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with a descriptive message.
4. Push the branch to your forked repository.
5. Create a pull request to the main repository.

## Feedback

We value your feedback! If you have suggestions, encounter issues, or want to propose improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Happy Dockerizing! 🚀

# 📦 How to Install DockerMate

# Add the DockerMate repository
sudo sh -c 'echo "deb [trusted=yes] https://nikhil-r21.github.io/dockermate/repo/ noble main" > /etc/apt/sources.list.d/dockermate.list'

# Import the GPG key
wget -qO - https://nikhil-r21.github.io/dockermate/repo-key.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dockermate.gpg

# Update package lists
sudo apt update

# Install DockerMate
sudo apt install dockermate

# Run it
sudo dockermate

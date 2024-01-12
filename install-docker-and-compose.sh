#!/bin/bash

# Stop execution if any command fails
set -e

# Update package manager
sudo apt update

# Install required packages for Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package manager with new Docker repository
sudo apt update

# Install the latest version of Docker
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Add current user to Docker group to run Docker without sudo (requires new shell or logout/login)
sudo usermod -aG docker $USER
echo "User added to Docker group. Please log out and log back in to apply changes."

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker
echo "Docker service started and enabled."

# Install the latest version of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
docker --version
docker-compose --version

echo "Latest Docker and Docker Compose installed successfully!"

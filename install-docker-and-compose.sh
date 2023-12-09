#!/bin/bash

# Stop execution if any command fails
set -e

# Update package manager
sudo apt update

# Install required packages for Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key and repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package manager with new Docker repository
sudo apt update

# Install Docker
sudo apt install docker-ce -y

# Add current user to Docker group to run Docker without sudo
sudo usermod -aG docker $USER

# Check Docker status
sudo systemctl status docker

# Install Docker Compose version 2.3.3
mkdir -p ~/.docker/cli-plugins/
curl -SL "https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64" -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# Verify Docker Compose installation
docker compose version

echo "Docker and Docker Compose v2.3.3 installed successfully!"
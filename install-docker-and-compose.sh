#!/bin/bash

# Stop execution if any command fails
set -e

echo "🔧 Starting Docker installation..."

# Update package manager
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package manager with new Docker repository
sudo apt update

# Install Docker Engine and Docker Compose v2 plugin
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Add current user to Docker group
sudo usermod -aG docker $USER
echo "✅ User added to Docker group. Please log out and log back in to apply changes."

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker
echo "✅ Docker service started and enabled."

# Verify installations
echo ""
echo "📦 Verifying installations..."
docker --version
docker compose version

echo ""
echo "✅ Docker and Docker Compose v2 installed successfully!"
echo "⚠️  Please log out and back in to use Docker without sudo."
echo ""
echo "💡 Note: Use 'docker compose' (with space) instead of 'docker-compose'"

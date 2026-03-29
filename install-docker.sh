#!/bin/bash

# Uninstall old versions
sudo apt remove -y $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc 2>/dev/null | cut -f1) && \
\
# Add Docker's official GPG key
sudo apt update && \
sudo apt install -y ca-certificates curl && \
sudo install -m 0755 -d /etc/apt/keyrings && \
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
sudo chmod a+r /etc/apt/keyrings/docker.asc && \
\
# Add the repository (Hardcoded to bookworm for MX Trixie compatibility)
echo "Types: deb
URIs: https://download.docker.com/linux/debian
Suites: bookworm
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc" | sudo tee /etc/apt/sources.list.d/docker.sources && \
\
# Install Docker Engine
sudo apt update && \
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
\
# Manage Docker as a non-root user
sudo usermod -aG docker "$USER" && \
newgrp docker

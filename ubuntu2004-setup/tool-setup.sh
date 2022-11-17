# This script installs Docker, Azure CLI, Kubectl and Helm on Ubuntu 20.04 machine.

#!/bin/bash

#General update
sudo apt-get update
sudo apt-get upgrade -y

#Install base tools
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    mc

#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $(ls /home/)

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Kubectl and Kubelogin
sudo az aks install-cli
echo 'source <(kubectl completion bash)' >> /home/*/.bashrc

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -

echo "deb https://baltocdn.com/helm/stable/debian/ all main" | \
sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get update
sudo apt-get install -y helm

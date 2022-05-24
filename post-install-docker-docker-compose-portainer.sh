#!/bin/sh

#
#
# Script zu Installation auf Oracle-Free-Tier-Cloud / Ampere arm64 / Ubuntu 20.04 
#
#

# install docker aarch64
#
sudo apt update && sudo apt upgrade -y
sudo apt install wget curl git mc htop
sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
newgrp docker
docker version
#
#
#
#install docker-compose 
#
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-aarch64 | cut -d '"' -f 4 | wget -qi -
chmod +x docker-compose-linux-aarch64
sudo mv docker-compose-linux-aarch64 /usr/local/bin/docker-compose
docker-compose version
sudo usermod -aG docker $USER
newgrp docker
#
#
#
# install portainer
#
#
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:2.9.3
    
echo "System up-to-date, Docker und Docker-Compose wurden installiert. Portainer auf Port 9443 wurde als Docker-Container hinzugefügt"

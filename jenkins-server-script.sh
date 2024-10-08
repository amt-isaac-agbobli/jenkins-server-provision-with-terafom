#!/bin/bash

# install jenkins

sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install -y java-17-amazon-corretto-devel
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# install git
sudo yum install git -y

# install terraform

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# install kubectl

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# Remove any existing Docker packages
for pkg in docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate 
docker-logrotate docker-engine; do sudo yum remove -y $pkg; done
sleep 5

# Install Docker
sudo amazon-linux-extras install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the docker group
sudo usermod -aG docker $USER
newgrp docker
sleep 5
#!/bin/bash

# Log everything for debugging
exec > >(tee /var/log/user-data.log) 2>&1
export DEBIAN_FRONTEND=noninteractive
echo "Starting EC2 setup..."

# Update packages
apt-get update -y

# Install Git
apt-get install -y git

# Install Python
apt-get install -y python3 python3-pip

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Install Nginx
apt-get install -y nginx

# Clone Application
cd /opt

if [ ! -d "flask-express-app" ]; then
    git clone -b ${github_branch} ${github_repo_url} flask-express-app
fi

# Backend Setup
cd /opt/flask-express-app/Docker\ Assignment/backend-se-tf
pip3 install --break-system-packages -r requirements.txt
nohup python3 app.py > backend.log 2>&1 &

# Frontend Setup
cd /opt/flask-express-app/Docker\ Assignment/frontend-se-tf
npm install
nohup node app.js > frontend.log 2>&1 &

# Configure Nginx
cp /opt/flask-express-app/Docker\ Assignment/frontend-se-tf/nginx.conf /etc/nginx/sites-available/default
nginx -t
systemctl restart nginx
echo "Deployment completed successfully."
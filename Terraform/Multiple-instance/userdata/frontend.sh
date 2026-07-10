#!/bin/bash

exec > >(tee /var/log/user-data.log) 2>&1

set -ex

echo "========== Frontend Setup Started =========="

apt-get update -y

apt-get install -y git curl

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

cd /opt

if [ ! -d "flask-express-app" ]; then
    git clone -b ${github_branch} ${github_repo} flask-express-app
fi

cd /opt/flask-express-app/Docker\ Assignment/frontend-me-tf

npm install

BACKEND_URL=http://${backend_public_ip}:5000 \
nohup node app.js > frontend.log 2>&1 &

echo "========== Frontend Setup Completed =========="
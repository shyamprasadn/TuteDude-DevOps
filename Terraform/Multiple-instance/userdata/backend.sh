#!/bin/bash

exec > >(tee /var/log/user-data.log) 2>&1

set -ex

echo "========== Backend Setup Started =========="

apt-get update -y

apt-get install -y \
git \
python3 \
python3-pip \
python3-venv

cd /opt

if [ ! -d "flask-express-app" ]; then
    git clone -b ${github_branch} ${github_repo} flask-express-app
fi

cd /opt/flask-express-app/Docker\ Assignment/backend-me-tf

python3 -m venv venv

source venv/bin/activate

pip install --upgrade pip

pip install -r requirements.txt

nohup python3 app.py > backend.log 2>&1 &

echo "========== Backend Setup Complete =========="
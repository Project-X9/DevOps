#!/bin/bash

cd /home/ubuntu/Downloads

sudo git clone -b devops https://github.com/Project-X9/BackEnd.git

cd /home/ubuntu/Downloads

sudo git clone -b Deployed https://github.com/Project-X9/FrontEnd.git

cd /home/ubuntu/Downloads
sudo chown -R ubuntu BackEnd

cd BackEnd

sudo npm install

cd /home/ubuntu/Downloads/FrontEnd/spotify
sudo npm install
sudo npm run build

cd /home/ubuntu/Downloads/BackEnd/src
export PORT=5000
pm2 start index.js --watch
pm2 save

#!/bin/bash

cd /home/omar/Downloads

sudo git clone https://github.com/Project-X9/BackEnd.git

cd /home/omar/Downloads

sudo git clone https://github.com/Project-X9/FrontEnd.git

cd /home/omar/Downloads
sudo chown -R omar BackEnd

cd BackEnd

sudo npm install

cd /home/omar/Downloads/FrontEnd/spotify
sudo npm install
sudo npm run build

cd /home/omar/Downloads/BackEnd/src
export PORT=5000
pm2 start index.js --watch
pm2 save

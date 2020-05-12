#!/bin/bash

#PLEASE READ THE LAST NOTE IN THE IMPORTANTGUIDELINES.TXT FILE
#NOTE THAT IF YOU WANT TO RUN THIS SCRIPT ON A REMOTE SERVER
#PLEASE REPLACE every "omar" with the "ubuntu"

cd /home/omar/Downloads

sudo git clone -b devops https://github.com/Project-X9/BackEnd.git

cd /home/omar/Downloads

sudo git clone -b Deployed https://github.com/Project-X9/FrontEnd.git

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

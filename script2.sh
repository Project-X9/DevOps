#!/bin/bash


#Cloning the repo


cd /opt

sudo git clone -b devops https://github.com/Project-X9/BackEnd.git

cd /opt

sudo git clone -b Deployed https://github.com/Project-X9/FrontEnd.git




#install Node npm dependencies

cd /opt

#change owner of the directory(npm install sometimes needed this to be done 1st)
sudo chown -R ubuntu BackEnd

cd BackEnd

#install back-end dependencies
sudo npm install




#install all front-end dependencies
cd /opt/FrontEnd/spotify
sudo npm install
sudo npm run build


cd /opt/BackEnd/src
#run the backend server using PM2
pm2 start index.js --watch
#to make pm2 start automatically when the server is rebooted
pm2 startup

sudo env PATH=$PATH:/usr/local/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

#save the list of processes you want to start when the server starts
pm2 save

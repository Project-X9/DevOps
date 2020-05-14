#!/bin/bash

#install node

#install nodejs package
sudo apt-get install -y nodejs

#install npm package
sudo apt-get install npm -y

#cleans the data in the cache folder
sudo npm cache clean -f

sudo npm install -g n

#upgrade to the latest stable node version
sudo n stable


#install nginx

sudo apt-get install nginx -y


#setup Git

sudo apt-get install git -y

#install and setup mongoDB

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 4B7C549A058F8B6B

echo deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse | sudo tee /etc/apt/sources.list.d/mongodb.list

#sudo nano (REMOVE THE QUOTATIONS)

sudo apt install udo

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo systemctl enable mongod && sudo systemctl start mongod


#install PM2

sudo npm install pm2 -g


#Cloning the repo


cd /opt

sudo git clone https://github.com/Project-X9/BackEnd.git

cd /opt

sudo git clone -b features https://github.com/Project-X9/FrontEnd.git


#Linking the project wit Nginx

sudo rm /etc/nginx/sites-available/default

sudo nano /etc/nginx/sites-available/default

#Then we edit the nginx config file


sudo systemctl restart nginx




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

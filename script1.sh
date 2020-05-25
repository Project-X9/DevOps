#!/bin/bash

#This script install the prerequisites needed for deployment

#updating the server

#updates the database with information on any new packages
sudo apt-get update


sudo apt-get install -y build-essential openssl libssl-dev pkg-config

#SETTING ENV VARIABLES

sudo nano /etc/environment
#Then you add the line PORT="3000" for example
#MONGODB_URL="mongodb+srv://admin:admin@projectx-test-d5geh.mongodb.net/projectx?retryWrites=true&w=majority"
#NODE_ENV="production"

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


#Linking the project wit Nginx

sudo rm /etc/nginx/sites-available/default

sudo nano /etc/nginx/sites-available/default

#Then we edit the nginx config file


sudo systemctl restart nginx

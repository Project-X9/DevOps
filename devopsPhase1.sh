#!/bin/bash


#updating the server

#updates the database with information on any new packages
sudo apt-get update


sudo apt-get install -y build-essential openssl libssl-dev pkg-config

#SETTING ENV VARIABLES

sudo nano /etc/environment
#Then you add the line PORT="3000" for example
#MONGODB_URL="mongodb+srv://admin:admin@projectx-test-d5geh.mongodb.net/projectx?retryWrites=true&w=majority"
#NODE_ENV="production"

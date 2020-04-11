# Prerequisites installations

Update the database with information on any new packages
>sudo apt-get update

>sudo apt-get install -y build-essential openssl libssl-dev pkg-config

**Install node**

Install nodejs package

>sudo apt-get install -y nodejs

Install npm package

>sudo apt-get install npm -y

Clean the data in the cache folder

>sudo npm cache clean -f

>sudo npm install -g n

Upgrade to the latest stable node version**

>sudo n stable

**Install nginx**

>sudo apt-get install nginx -y

**Install Git**

>sudo apt-get install git -y

**Install and setup mongoDB**

>sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 4B7C549A058F8B6B

>echo deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse | sudo tee /etc/apt/sources.list.d/mongodb.list

>sudo apt install udo

>sudo apt-get update

>sudo apt-get install -y mongodb-org

>sudo service mongod start

>sudo systemctl enable mongod && sudo systemctl start mongod

**Install PM2**

>sudo npm install pm2 -g


# Complete steps documentation
### After installing the previous tools, we need to do the following:
**Set the environment variables**

Run this command
> sudo nano /etc/environment

Then append the following lines:
PORT="3000" 
MONGODB_URL="mongodb+srv://admin:admin@projectx-test-d5geh.mongodb.net/projectx?retryWrites=true&w=majority"
NODE_ENV="production"

Then press ctrl+o to save, then ctrl+x to exit the editor

Make sure that you logout of the remote server and ssh back in after you do so, in order for the environment variables to get set


**Clone the repo**

Simply run the following commands to clone them into the /opt directory (or cd into any directory you want and clone it there)

>cd /opt

>sudo git clone https://github.com/Project-X9/BackEnd.git

>cd /opt

>sudo git clone -b features https://github.com/Project-X9/FrontEnd.git


**Linking the project wit Nginx**

Run the following commands
>sudo rm /etc/nginx/sites-available/default

>sudo nano /etc/nginx/sites-available/default

Then we edit the nginx config file as shown in the IMPORTANTGUIDLINES.txt file
Then restart nginx using the following command
>sudo systemctl restart nginx

**Installing dependencies**

Go to the directory in which you cloned the Backend repo, and install the dependencies by running the following commands:
>cd /opt

>sudo chown -R ubuntu BackEnd

>cd BackEnd

>sudo npm install

Then go to the directory of the cloned Frontend repo, and install their dependencies using the following commands:
>cd /opt/FrontEnd/spotify

>sudo npm install

Then create a build directory with a production build of the app using the following command:
>sudo npm run build

**Starting the backend api**

First, run the backend server using pm2

>cd /opt/BackEnd/src

>pm2 start index.js --watch

To make pm2 start automatically when the server is rebooted, run the following two  commands:

>pm2 startup

>sudo env PATH=$PATH:/usr/local/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

Then save the list of processes you want to start when the server starts

>pm2 save

Now restart nginx 

>sudo service nginx stop && sudo service nginx start

## Files needed for deployment
Nginx configuration file:

server {

listen 80 default_server;

server_name _;

#react app & front-end files

location / {

root /opt/FrontEnd/spotify/build;

try_files $uri /index.html;

}

#node api reverse proxy

location /api/ {

proxy_pass http://localhost:3000/;

}

}

# Credentials to access the server using ssh

To connect the the EC2 instance, you'll need a private key (.pem) file, and you'll need the username and the public DNS of the server.
For our server, the username is "ubuntu", and the public DNS is  "ec2-3-21-218-250.us-east-2.compute.amazonaws.com".
You'll also find the pem file in the DevOps repo, it's called firstTest-ec2.pem.
So, if you have the necessary .pem file required to ssh into the server, you'll need to go into the directory containing this .pem file, and then you can ssh into the server using the following command:
>ssh -i "firstTest-ec2.pem" ubuntu@ec2-3-21-218-250.us-east-2.compute.amazonaws.com













# Prerequisites installations

**Please note that your ubuntu username is assumed to be "ubuntu"**

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

>sudo systemctl enable mongod && sudo systemctl start mongod

**Install PM2**

>sudo npm install pm2 -g

**Install pip for python-3**

>sudo apt install python3-pip

**Install python3-distutils package**

>sudo apt-get install python3-distutils

**Install xvfb**

>sudo apt-get install xvfb

**Install Jenkins**

First, we need to install java JDK using the following commands
>sudo apt update

>sudo apt install default-jdk

Then, to install the latest version of Jenkins, we need to add the Jenkins repository key and then update our packages to be able to use the repository using the following commands
>wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

>sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

>sudo apt-get update

Now, we can install Jenkins by simply running the following command
>sudo apt-get install jenkins

Finally, to allow Jenkins to perform commands using sudo, we need to run the following command
>sudo visudo

and then append this line to the end 
>jenkins ALL= (ALL) NOPASSWD: ALL

And then save to sudoers (not sudoers.tmp)

Now, Jenkins should be running on port 8080, but you need the initial admin password to be able to access it for the first time, before you set your own username and password.
To get the password, run the following command
>sudo cat /var/lib/jenkins/secrets/initialAdminPassword

And now the password will be written on your terminal




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

>sudo git clone -b devops https://github.com/Project-X9/BackEnd.git

>cd /opt

>sudo git clone -b Deployed https://github.com/Project-X9/FrontEnd.git


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

**Now we need to setup two other directories which will contain the Back end and the Front end files, as these will be needed in Jenkins to run tests before deployment.**

The second backend api will run on port 5000, while the frontend files will be served using nginx, and they will be served on port 4000.

**Clone the repo**

Simply run the following commands to clone the backend and frontend repos 

>cd /home/ubuntu/Downloads

>sudo git clone -b devops https://github.com/Project-X9/BackEnd.git

>cd /home/ubuntu/Downloads

>sudo git clone -b Deployed https://github.com/Project-X9/FrontEnd.git

**Installing dependencies**

Go to the directory in which you cloned the backend repo for the second time, and install the dependencies using the following commands

>cd /home/ubuntu/Downloads

>sudo chown -R ubuntu BackEnd

>cd BackEnd

>npm install

Then go to the directory in which you cloned the frontend repo for the second time, and install the dependencies using the following commands

>cd /home/ubunu/Downloads/FrontEnd/spotify

>sudo npm install

>sudo npm run build

**Starting the second backend api**

We will start the second backend api on port 5000 this time using the following commands

>cd /home/ubuntu/Downloads/BackEnd/src

We will set the PORT environment variable to be equal to 5000 temporarily (for this terminal session only), and then we will start the backend api. This way, it will run on port 5000.

>export PORT=5000

>pm2 start index.js --watch

Then save the list of processes you want to start when the server starts

>pm2 save


**Clone the Testing repo**

Now we want to clone the Testing repo, in order to be able to run these tests using Jenkins later on.

First, we will clone the repo using the following commands
>cd /home/ubuntu/Downloads

>git clone -b DevOpsB https://github.com/Project-X9/Testing.git

**Installing the Testing dependencies**

To install the testing dependencies, simply run the following command
>cd /home/ubuntu/Downloads/Testing

>python3 -m pip install -r requirements.txt

We then need to generate a geckodriver log file, and allow others to write to it (as Jenkins needs this permission) as follows

>touch geckodriver.log

>chmod 646 geckodriver.log



## Jenkins Scripts
**Setting the webhooks**

To add a webhook to a Github repository, we need to go to the repository’s settings, then select Webhooks, then click on Add a webhook.

The payload url should be the Jenkins URL, followed by “/github-webhook/”.

The content type should be application/json, and I chose “just the push event” to trigger the webhook.


**Jenkins pipeline stage 0**

Now that our webhooks have been set, we need to create Jenkins jobs using the Jenkins interface, so first, we will create a job which will execute the following script:

>cd /home/ubuntu/Downloads/Testing

>python3 -m pip install -r requirements.txt

This Job will be executed only once, just to install the Testing dependencies so that Jenkins can run the tests.

**Jenkins pipeline stage 1**

This stage will contain three parallel jobs, each of which is executed whenever a push is made to the BackEnd, FrontEnd, or Testing repositories.

The first job is called the **BackEndListener**, which will be triggered whenever a push is made to the BackEnd repository (by a webhook in the BackEnd repository), then it will execute the following script:

>Cd /home/ubuntu/Downloads/BackEnd

>export PORT=5000

>sudo git pull origin devops

>sudo npm install

This will clone the updated BackEnd repository into another directory other than the one containing the BackEnd api running on port 3000. This version will be running on port 5000.


The second job is called the **FrontEndListener**, which will similarly be triggered by means of a webhook in the FrontEnd repository at every push, then it will execute the following script:

>cd /home/ubuntu/Downloads/FrontEnd

>sudo git pull origin Deployed

>cd /home/ubuntu/Downloads/FrontEnd/spotify

>sudo npm install

>sudo npm run build

This will clone the updated FrontEnd repository into another directory other than the one containing the FrontEnd files served at port 80. This version is served at port 4000, and the api requests made from port 4000 are redirected to port 5000, so it communicates with the BackEnd api at port 5000.

The third job is called the **TestingListener**, which will similarly be triggered by means of a webhook in the Testing repository at every push, then it will execute the following script:

>cd /home/ubuntu/Downloads/Testing

>sudo git pull origin DevOpsB

This will simply pull the updated Testing repository and update the Tests to be run.

**Jenkins pipeline stage 2**

The second stage will be triggered if any of the previous three jobs were triggered and executed successfully.

It will execute the following script:

>cd /home/ubuntu/Downloads/Testing

>python3 -m pytest ./Web_Testing/Tests/test_webplayerHome.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_login.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_accountoverview.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_artist.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_changePassword.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_likedsongs.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_loggedOutHome.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_playlist.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_premium.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_signup.py -m Do

>python3 -m pytest ./Web_Testing/Tests/test_yourLibrary.py -m Do

This will go into the directory containing the tests, and will run them. These tests will be run on the files served at port 4000(as set by the Testing team in the version on the DevOpsB Branch), which communicate with the backend API at port 5000, hence, it will run on the new version of the app, and if the tests are passed, this version should be deployed.

If any of the tests contains a failed test case, the Testing team makes the code exit with System code (-1), which marks the Jenkins build as a failure, and hence the next stage (Deployment) will not be executed. Also, if any of the tests failed, then the remaining tests will not be executed, and this makes sense, because one failed test means that the new version will not be deployed, so there’s no point in running the remaining tests.


**Jenkins pipeline stage 3**

This stage will be triggered if stage 2 (Running the tests) was completed successfully with no failed test cases. It will execute the following script:


>cd /opt/BackEnd/

>sudo git pull origin devops

>sudo npm install

>cd /opt/FrontEnd

>sudo git pull origin Deployed

>cd /opt/FrontEnd/spotify

>sudo npm install

>sudo npm run build

This script will go into the directory containing the BackEnd api running at port 3000, and pull the latest version, and will go into the directory containing the FrontEnd files served at port 80, and communicating with the BackEnd API at port 3000, and will pull and build the latest FrontEnd files


**Jenkins E-mail notifications**

To setup Jenkins to be able to send E-mail notifications, we need to first go to Manage Jenkins, then to Configure System, then find the E-mail notification part. Now, we need to first set the SMTP server. In case we were going to use Gmail, we will set the SMTP server to be “smtp.gmail.com”.

Then, in the advanced section, choose use SMTP authentication, and the username and the password should be both your Gmail email and password.

Check the use SSL check box, and the SMTP port should be 465 in case of Gmail.

Now, in our Jenkins Jobs configuration, we can configure Jenkins to send an email notification by going to the Post-build Actions and choosing E-mail Notification, then we can specify the recipient email which will receive the notification in case of a failed build.





## Files needed for deployment
Nginx configuration file:


server {

listen 80 default_server;

server_name _;


location / {

root /opt/FrontEnd/spotify/build;

try_files $uri /index.html;

}

location /images/ {

root /home/ubuntu;

}


location /api/ {

proxy_pass http://localhost:3000/;

}

}

server {

listen 4000;

server_name _;


location / {

root /home/ubuntu/Downloads/FrontEnd/spotify/build;

try_files $uri /index.html;

}


location /api/ {

proxy_pass http://localhost:5000/;

}

}

# Credentials to access the server using ssh

To connect the the EC2 instance, you'll need a private key (.pem) file, and you'll need the username and the public DNS of the server.
For our server, the username is "ubuntu", and the public DNS is  "ec2-3-21-218-250.us-east-2.compute.amazonaws.com".
So, if you have the necessary .pem file required to ssh into the server, you'll need to go into the directory containing this .pem file, and then you can ssh into the server using the following command:
>ssh -i "mypem.pem" ubuntu@ec2-3-21-218-250.us-east-2.compute.amazonaws.com

assuming that your pem file name is "mypem.pem"



# Used Tools


>AWS EC2 services

>AWS SES

>Nginx web server

>PM2

>Git

>Jenkins

There were also some tools that needed to be installed so that the web application would work:

>Node JS

>MongoDB






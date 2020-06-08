# General Guidlines 
To deploy our app, you first need to SSH into an EC2 instance
Make sure you have the following ports open

>HTTP

>HTTPS

>SMTP

>3000

>8080

>8090

>4000

>5000

Then, you should run script1, which will set the environment variables (Please refer to the "Set the environment variables" section inside the "Complete steps documentation" section to know what environment variables your should set when prompted), install any needed deployment prerequisites, and will edit the nginx configuration file, which you can copy and paste from the "Files needed for Deployment" section.

Afterwards, exit and SSH back into the EC2 instance, so that the environment variables will be set.

Then, run script2, which will clone the frontend and backend repos, install their dependencies, build the frontend files, and start the backend API on port 3000.

You should also run the mailserver script, to setup the server to send emails.
Please refer to the "Setting up the mailserver" section, inside the "Prerequisite installations" section, and make sure you perform the prerequisites required to work with Amazon SES first.

At this point, you have successfully deployed the web application.

If you want to setup the Jenkins automation process, proceed to run Jenkinsinstall, script3, and script4, which will install Jenkins, clone another version of the web app to run the tests on, and clone the Tests that will be run.

You should then go to port 8080 to access Jenkins, and install the suggested plugins.

Create 6 Jobs as shown in the JenkinsScripts.txt file, and make sure to set the webhooks on the stage 1 jobs, and to make Stage 2 triggered by stage 1, and to make stage 3 triggered by stage 2.

Also make sure to run stage 0 one time only at the beginning to install the dependencies needed for Testing.

At this point, you should be all set.


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


**Setting up the mail server**

First, we need to install PHP as follows:

Install the commands that will let us add a software repository

>sudo apt install software-properties-common

Now add the repository and install PHP 7.4

>sudo add-apt-repository ppa:ondrej/php

>sudo apt update

>sudo apt install -y php7.4

>sudo apt-cache search php7*

To check that we have the right version now

>php -v


Next, we need to change the default Apache HTTP port, because we already have Nginx listening on port 80, so Apache cannot listen on the same port, so we’ll change it to port 8090 as follows:


Edit **ports.conf** file and change the line “Listen 80” to “Listen 8090”

>sudo nano /etc/apache2/ports.conf

We also have to change the line _“<VirtualHost *:80_>” to  _“<VirtualHost *:8090>”_ in the **000-default.conf** file too as follows:

>sudo nano /etc/apache2/sites-enabled/000-default.conf


Then, restart Apache service to make the changes take effect

>sudo systemctl restart apache2


Now, we need to install the Composer Dependency Manager as shown in the following steps:

Download the installer to the current directory

>php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

Verify the installer SHA-384

>php -r "if (hash_file('sha384', 'composer-setup.php') ==='e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

Run the installer

>sudo php composer-setup.php


Remove the installer

>php -r "unlink('composer-setup.php');"

Install the PHPMailer class

>/home/ubuntu/composer.phar require phpmailer/phpmailer

>/home/ubuntu/composer.phar fund


There are also some prerequisites required to work with the Amazon SES:

A- Verify your email address with Amazon SES:

>You must verify each identity that you use as a "From," "Source," "Sender," or "Return-Path" address.

>Amazon SES has endpoints in multiple AWS Regions, and the verification status of the email address is separate for each region. If you want to send email from the same identity in more than one region, you must verify that identity in each region.

>Here are the full steps of how to verify your email address :  
[https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses-procedure.html](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses-procedure.html)

B- Verifying Domains in Amazon SES:

>Amazon SES requires that you verify your email address or domain, to confirm that you own it and to prevent others from using it.

>When you verify an entire domain, you are verifying all email addresses from that domain, so you don't need to verify email addresses from that domain individually.

>Here are the full steps to verify a domain :  
[https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-domain-procedure.html](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-domain-procedure.html)


C- Get your SMTP credentials:

>You need an Amazon SES SMTP user name and password to access the Amazon SES SMTP interface.

>Here are the full steps for getting SMTP credentials:  
[https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html)


Now, to send sending an email using the Amazon SES SMTP interface with PHP, do the following:

Create a file named  **amazon-ses-smtp-sample.php**

>touch amazon-ses-smtp-sample.php

Open the file with a text editor

>nano amazon-ses-smtp-sample.php

Then, copy the contents of the attached **amazon-ses-smtp-sample.php** file (You can find it in the Repository and in the submitted compressed file), and paste it in there

Then, to send an email, navigate to the directory in which the **amazon-ses-smtp-sample.php** file was saved, and run the following command:

>php amazon-ses-smtp-sample.php

Review the output. If the email was successfully send, the terminal will display “Email sent!”, Otherwise, it displays an error message.

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

Then we edit the nginx config file as shown in the "Files needed for deployment" section
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


**Explanation**


The first server block listens to port 80, and it was set as the default server, meaning that, any request that doesn’t match any of the server_names, will be dealt with by this block.

The server name was also set to “_”, this means that it will catch any server name. In our case, we don’t have multiple web apps being served on different domains or anything, so this works fine.

The first location block in the first server block will catch requests starting with “/”, and will serve these requests from the root directory, so for example, the request “/signup” will be served with the signup html page in the root directory. If an invalid request is send, such as “/nonexistent/”, this will be served by default with the index.html page in the root directory.

The second location block will catch requests starting with “/images/”, and will serve these requests from the root directory, which is “/home/Ubuntu/images/” (Note that Nginx appends the “/images/” part to the root directory). This was made to serve images stored on the server using Nginx.

The third location block will catch requests starting with “/api/”, and will redirect these requests to port 3000, on which the backend API is running.

The second server block listens on port 4000, and it has two location blocks, very similar to the first and the third location blocks in the first server block. However, a key difference is that the first location block here will serve the frontend files stored in a different directory, and its API requests are routed to port 5000 this time (on which another backend API is running). This is done because whenever a new push is made to the frontend repository, it will be pulled (by Jenkins) in the specified root directory of the first location block, and also if a new push is made to the backend repository, it will be pulled and it will run on port 5000, which is the port that receives the API requests from port 4000. So, we have a second version of our application, on which the tests will be run (using Jenkins), and in case these tests passed, this new version will be Deployed using Jenkins as well.


# Credentials to access the server using ssh

To connect the the EC2 instance, you'll need a private key (.pem) file, and you'll need the username and the public DNS of the server.
For our server, the username is "ubuntu", and the public DNS is  "ec2-3-21-218-250.us-east-2.compute.amazonaws.com".
So, if you have the necessary .pem file required to ssh into the server, you'll need to go into the directory containing this .pem file, and then you can ssh into the server using the following command:
>ssh -i "mypem.pem" ubuntu@ec2-3-21-218-250.us-east-2.compute.amazonaws.com

assuming that your pem file name is "mypem.pem"



# Used Tools


>AWS EC2 services

>AWS SES SMTP Interface

>Nginx web server

>PM2

>Git

>Jenkins

>PHP and PHPMailer

There were also some tools that needed to be installed so that the web application would work:

>Node JS

>MongoDB





# Necessary Citations
>The Nginx configuration file was firstly inspired from this tutorial, hence you might notice some similarities.

[https://www.youtube.com/watch?v=FanoTGjkxhQ&t=589s](https://www.youtube.com/watch?v=FanoTGjkxhQ&t=589s)

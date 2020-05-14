#!/bin/bash

cd /home/omar/Downloads

git clone -b DevOpsB https://github.com/Project-X9/Testing.git

cd Testing
sudo apt install python3-pip
sudo apt-get install python3-distutils


python3 -m pip install -r requirements.txt
sudo apt-get install xvfb
#READY TO RUN TESTS


cd /home/omar/Downloads/Testing

touch geckodriver.log
chmod 646 geckodriver.log

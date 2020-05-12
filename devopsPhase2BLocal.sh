#!/bin/bash

#PLEASE READ THE LAST NOTE IN THE IMPORTANTGUIDELINES.TXT FILE
#NOTE THAT IF YOU WANT TO RUN THIS SCRIPT ON A REMOTE SERVER
#PLEASE REPLACE every "omar" with the "ubuntu"

cd /home/omar/Downloads

git clone -b DevOpsB https://github.com/Project-X9/Testing.git

cd Testing
sudo apt install python3-pip
sudo apt install python-pip
sudo apt-get install python3-distutils

sudo apt install curl

curl https://bootstrap.pypa.io/get-pip.py | python
python3 -m pip install -r requirements.txt
sudo apt-get install xvfb

#READY TO RUN TESTS

python3 -m pytest ./Web_Testing/Tests/test_changePassword.py -m Do

cd /home/omar/Downloads/Testing
chmod 777 geckodriver.log

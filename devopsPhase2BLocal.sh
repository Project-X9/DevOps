#!/bin/bash

cd /home/omar/Downloads

git clone -b DevOpsB https://github.com/Project-X9/Testing.git

cd Testing
sudo apt install python3-pip
sudo apt install python-pip
sudo apt-get install python3-distutils

#INSTALL CURL
sudo apt install curl
curl https://bootstrap.pypa.io/get-pip.py | python
sudo apt install python3-pip
python3 -m pip install -r requirements.txt
python3 -m pip install pyvirtualdisplay
sudo apt-get install xvfb
#READY TO RUN TESTS

python3 -m pytest --alluredir="./Reports/All_Reports/allurefiles" ./Web_Testing/Tests/test_changePassword.py -m Do

cd /home/omar/Downloads/Testing
chmod 777 geckodriver.log
cd /home/omar/Downloads/Testing/Reports/All_Reports
chmod -R 777 allurefiles

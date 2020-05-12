#!/bin/bash

python3 -m pytest ./Web_Testing/Tests/test_accountoverview.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_artist.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_changePassword.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_likedsongs.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_loggedOutHome.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_login.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_playlist.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_premium.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_signup.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_webplayerHome.py -m Do

python3 -m pytest ./Web_Testing/Tests/test_yourLibrary.py -m Do



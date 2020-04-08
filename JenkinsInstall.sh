#installing jenkins

#installing java
sudo apt update
sudo apt install default-jdk

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update

sudo apt-get install jenkins

#To execute a sudo shell command from jenkins

sudo visudo

#add this line to the very end
#jenkins ALL= (ALL) NOPASSWD: ALL
#Then save to sudoers,not sudoers.tmp

#Get the initialpassword
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


#! /bin/bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php7.4

sudo nano /etc/apache2/ports.conf
#change listen 80 to listen 8090
sudo nano /etc/apache2/sites-enabled/000-default.conf
#<VirtualHost *:8090>
sudo systemctl restart apache2

sudo apt-cache search php7*
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
php -r "unlink('composer-setup.php');"
/home/ubuntu/composer.phar require phpmailer/phpmailer
/home/ubuntu/composer.phar fund
touch amazon-ses-smtp-sample.php
nano amazon-ses-smtp-sample.php
php amazon-ses-smtp-sample.php

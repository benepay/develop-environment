#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='password'

# update / upgrade
sudo apt -y update
sudo apt -y upgrade

# # install apache and php 7
sudo apt install -y apache2
sudo apt install -y php libapache2-mod-php

# # install ntpdate
sudo apt install -y ntpdate
sudo ntpdate ntp.ubuntu.com

# # install curl and mcrypt
sudo apt install -y php-curl php-mcrypt php-gd php-gmp php-bcmath php-mbstring php-soap php-pdo php-xml php-mysql php-pear php-dev
sudo apt install -y git build-essential python libtool autoconf pkg-config python-software-properties wget nano vim zip curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev

# # install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt install -y mysql-server
sudo apt install -y php-mysql

# # install phpmyadmin and give password(s) to installer
# # for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt install -y phpmyadmin

# # enable mod_rewrite
sudo a2enmod rewrite

# # restart apache
sudo service apache2 restart
# # restart mysql
sudo service mysql restart

# # install Composer
sudo apt install -y composer

# # install Node
cd /home/ubuntu
wget https://github.com/nodejs/node/archive/v8.9.3.zip
unzip v8.9.3.zip && mv node-8.9.3 node
cd node
./configure
make -j 4
sudo make install
cd /home/ubuntu
sudo npm install -g pm2

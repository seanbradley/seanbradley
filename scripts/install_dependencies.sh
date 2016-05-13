#!/bin/bash

#See /var/log/cloud-init.log for troubleshooting.

yum update -y
yum groupinstall -y "Web Server" "MySQL Database" "PHP Support"
yum install -y php-mysql
yum install -y openssh-clients

##########
#Install WordPress
##########


#Alternatively, consider setting MySQL root password
#during this phase of CodeDeploy...

#This is possible via mysql-server.

#The following commands set the MySQL root password to
#MYPASSWORD123 when installing mysql-server package.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password y3ll0wst0ne3'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password y3ll0wst0ne3'

mkdir /var/www/html/wolfskill
#mkdir /var/www/html/
#cd /var/www/html/
#wget http://wordpress.org/latest.tar.gz
#tar xfz latest.tar.gz
#mkdir wolfskill
#mv ./wordpress/* ./wolfskill
#rmdir ./wordpress/
#rm -f latest.tar.gz
cd /var/www/html/wolfskill
mkdir scripts

##########
#Fetch WordPress config from S3...
##########

if [ -f /var/www/html/wolfskill/wp-config.php ]; then
    rm -rf /var/www/html/wolfskill/wp-config.php
fi

if [ -f /var/www/html/wolfskill/scripts/wolfskill_config.sh ]; then
    rm -rf /var/www/html/wolfskill/scripts/wolfskill_config.sh
fi

if [ -f /var/www/html/wolfskill/scripts/config.sh ]; then
    rm -rf /var/www/html/wolfskill/scripts/config.sh
fi

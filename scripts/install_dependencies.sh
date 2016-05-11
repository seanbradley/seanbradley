#!/bin/bash

#See /var/log/cloud-init.log for troubleshooting.

yum update -y
yum groupinstall -y "Web Server" "MySQL Database" "PHP Support"
yum install -y php-mysql

#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.

#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'

#See https://rbgeek.wordpress.com/2014/08/07/automated-installation-of-lamp-stack-on-ubuntu-server/

yum install -y openssh-clients

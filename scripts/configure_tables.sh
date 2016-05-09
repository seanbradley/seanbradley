#!/bin/bash -xe

##########
#This file must stay out of version control.
##########

mysql -hlocalhost -uroot -ppepperoni -e "DROP USER ''@'localhost'; DROP USER ''@'ec2-54-203-124-26.us-west-2.compute.amazonaws.com'; CREATE DATABASE deploypressdb; CREATE USER 'cougarbait'@'localhost'; GRANT ALL PRIVILEGES ON deploypressdb.* TO 'cougarbait'@'localhost' IDENTIFIED BY 'secretpizza'; FLUSH PRIVILEGES;"
exit

#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

mysql -hlocalhost -uroot -ppepperoni -e "CREATE DATABASE wolfdendb; CREATE USER 'bluewolf'@'localhost'; GRANT ALL PRIVILEGES ON wolfdendb.* TO 'bluewolf'@'localhost' IDENTIFIED BY 'victorytrail'; FLUSH PRIVILEGES;"
exit


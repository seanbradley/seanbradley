#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

##########
#create a new root password for MySQL
##########
cd /var/www/html/deploypress

service mysqld start

mysql -uec2-user -hlocalhost -e "UPDATE mysql.user SET Password = PASSWORD('pepperoni') WHERE User = 'root'; FLUSH PRIVILEGES;"
exit

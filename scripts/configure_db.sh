#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

##########
#create a new root password for MySQL
##########
cd /var/www/html/wordpress

service mysqld start

mysql -uec2-user -hlocalhost -e "UPDATE mysql.user SET Password = PASSWORD('y3ll0wst0ne3') WHERE User = 'root'; FLUSH PRIVILEGES;"
exit

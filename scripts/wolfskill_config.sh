#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

#See /var/log/cloud-init.log for troubleshooting.
#curl -O \
#https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
       
##########
#Write global envvars to ~/.bashrc
##########

export ROOTSQLPASS=y3ll0wst0n3 >> ~/.bashrc
export DB_NAME=wolfdendb >> ~/.bashrc
export DB_USER=bluewolf >> ~/.bashrc
export DB_PASSWORD=victorytrail >> ~/.bashrc
export AUTH_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export SECURE_AUTH_KEY=fnwpevfzcbvohyxcibsvfqevqumrggolqqgtzvgqcpvjhbiubihgfmioouchqtafivfqdi >> ~/.bashrc
export LOGGED_IN_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export NONCE_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export AUTH_SALT=jquwvjqyrblwibrsrihrflwvmmkyjgrhaabwyocxddqppfqsomtqrjvvaegecbjnwalogg >> ~/.bashrc
export SECURE_AUTH_SALT=xyjpkgynshupihzadpregnlfpzkahpmuaomsnwcxfexkjajholpupjyqwrybwxhxuewhmj >> ~/.bashrc
export LOGGED_IN_SALT=xbddaizfzegzrfhmbpmkgjzrdivcdcgarfblyqozeeaxkqhwstmdlnjhtusowfrlakvivd >> ~/.bashrc
export NONCE_SALT=xbddaizfzegzrfhmbpmkgjzrdivcdcgarfblyqozeeaxkqhwstmdlnjhtusowfrlakvivd >> ~/.bashrc

##########
#Overwrite values in wp-config.php to match ~/.bashrc
##########

DBPORIG="'DB_PASSWORD', ''"
DBPNEW="'DB_PASSWORD', '$DB_PASSWORD'"

cd /var/www/html/wolfskill

#see http://stackoverflow.com/questions/4870253/\
#sed-replace-single-double-quoted-text
#confirm sed works for changing the DB_PASSWORD; #nesting envvars here...

sed -i "
s/'test'/'$DB_NAME'/g
s/'root'/'$DB_USER'/g
s/'$DBPORIG'/'$DBPNEW'/g
s/'put your unique phrase here'/'$AUTH_KEY'/g
s/'put your unique phrase here'/'$SECURE_AUTH_KEY'/g
s/'put your unique phrase here'/'$LOGGED_IN_KEY'/g
s/'put your unique phrase here'/'$NONCE_KEY'/g
s/'put your unique phrase here'/'$AUTH_SALT'/g
s/'put your unique phrase here'/'$SECURE_AUTH_SALT'/g
s/'put your unique phrase here'/'$LOGGED_IN_SALT'/g
s/'put your unique phrase here'/'$NONCE_SALT'/g" wp-config.php

##########
#Tweak httpd.conf
##########

#WordPress permalinks need to use Apache .htaccess #files to work properly, but this is not enabled by #default on Amazon Linux. Use this procedure to #allow all overrides in the Apache document root.

#cd /etc/httpd/conf
#sudo nano httpd.conf
#<Directory "/var/www/html">
#
#    AllowOverride All

#confirm awk works on httpd.conf
cd /etc/httpd/conf
awk '/<Directory \/var\/www\/>/,/AllowOverride None/{sub("None", "All",$0)}{print}'

##########
#Start and configure mysql
##########

service mysqld start

mysql -hlocalhost -uec2-user -e "UPDATE mysql.user SET Password = PASSWORD('y3ll0wst0ne3') WHERE User = 'root'; FLUSH PRIVILEGES;"
exit

mysql -hlocalhost -uroot -py3ll0wst0ne3 -e "DROP USER ''@'localhost'; DROP USER ''@'ec2-54-188-227-137.us-west-2.compute.amazonaws.com'; CREATE DATABASE wolfdendb; CREATE USER 'bluewolf'@'localhost'; GRANT ALL PRIVILEGES ON wolfdendb.* TO 'bluewolf'@'localhost' IDENTIFIED BY 'victorytrail'; FLUSH PRIVILEGES;"
exit

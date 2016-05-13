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
export LOGGED_IN_KEYn=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
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


#[stdout]Starting mysqld:  [  OK  ]

#[stderr]+ mysql -hlocalhost -uec2-user -e 'UPDATE mysql.user SET Password = PASSWORD('\''y3ll0wst0ne3'\'') WHERE User = '\''root'\''; FLUSH PRIVILEGES;'
#[stderr]ERROR 1142 (42000) at line 1: UPDATE command denied to user ''@'localhost' for table 'user'

#mysql -hlocalhost -uec2-user -e "UPDATE mysql.user SET Password = PASSWORD('y3ll0wst0ne3') WHERE User = 'root'; FLUSH PRIVILEGES;"
#exit

#[stdout]PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
#[stdout]To do so, start the server, then issue the following commands:
#[stdout]
#/usr/libexec/mysql55/mysqladmin -u root password 'y3ll0wst0ne3'
#/usr/libexec/mysql55/mysqladmin -uroot -hlocalhost -py3ll0wst0ne3
#[stdout]s
#[stdout]Alternatively you can run:
#[stdout]/usr/libexec/mysql55/mysql_secure_installation
#[stdout]
#[stdout]which will also give you the option of removing the test
#[stdout]databases and anonymous user created by default.  This is
#[stdout]strongly recommended for production servers.
#[stdout]

mysql -hlocalhost -uroot -py3ll0wst0ne3 -e "CREATE DATABASE IF NOT EXISTS wolfdendb; CREATE USER IF NOT EXISTS 'bluewolf'@'localhost'; GRANT ALL PRIVILEGES ON 'wolfdendb.*' TO 'bluewolf'@'localhost' IDENTIFIED BY 'victorytrail'; FLUSH PRIVILEGES;"
#/etc/mysql/my.cnf
#mysql -hlocalhost -e "CREATE DATABASE wolfdendb; CREATE USER 'bluewolf'@'localhost'; GRANT ALL PRIVILEGES ON wolfdendb.* TO 'bluewolf'@'localhost' IDENTIFIED BY 'victorytrail'; FLUSH PRIVILEGES;"
exit

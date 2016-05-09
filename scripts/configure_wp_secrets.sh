#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

#See /var/log/cloud-init.log for troubleshooting.
#curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#declare db secrets
#make sure escaped chars are not a problem
#may require touch .bashrc first; then >> ~/.bashrc
    
    
##########
#write global envvars to ~/.bashrc
##########
export ROOTSQLPASS=pepperoni >> ~/.bashrc
export DB_NAME=deploypressdb >> ~/.bashrc
export DB_USER=cougarbait >> ~/.bashrc
export DB_PASSWORD=secretpizza >> ~/.bashrc
export AUTH_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export SECURE_AUTH_KEY=fnwpevfzcbvohyxcibsvfqevqumrggolqqgtzvgqcpvjhbiubihgfmioouchqtafivfqdi >> ~/.bashrc
export LOGGED_IN_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export NONCE_KEY=fqroipcdztpjrgipuyymgqitybmzehkygqoscpqrcokewnlimarextgbbvhkoupkyroifs >> ~/.bashrc
export AUTH_SALT=jquwvjqyrblwibrsrihrflwvmmkyjgrhaabwyocxddqppfqsomtqrjvvaegecbjnwalogg >> ~/.bashrc
export SECURE_AUTH_SALT=xyjpkgynshupihzadpregnlfpzkahpmuaomsnwcxfexkjajholpupjyqwrybwxhxuewhmj >> ~/.bashrc
export LOGGED_IN_SALT=xbddaizfzegzrfhmbpmkgjzrdivcdcgarfblyqozeeaxkqhwstmdlnjhtusowfrlakvivd >> ~/.bashrc
export NONCE_SALT=xbddaizfzegzrfhmbpmkgjzrdivcdcgarfblyqozeeaxkqhwstmdlnjhtusowfrlakvivd >> ~/.bashrc


#see http://stackoverflow.com/questions/4870253/sed-replace-single-double-quoted-text
#confirm sed works for changing the DB_PASSWORD; nesting envvars here...


##########
#overwrite values in wp-config.php to match ~/.bashrc
##########

DBPORIG="'DB_PASSWORD', ''"
DBPNEW="'DB_PASSWORD', '$DB_PASSWORD'"

cd /var/www/html/deploypress
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

#WordPress permalinks need to use Apache .htaccess files to work 
#properly, but this is not enabled by default on Amazon Linux. Use 
#this procedure to allow all overrides in the Apache document root.


##########
#tweak httpd.conf
##########

#cd /etc/httpd/conf
#sudo nano httpd.conf
#<Directory "/var/www/html">
#
#    AllowOverride All

#confirm awk works on httpd.conf
cd /etc/httpd/conf
awk '/<Directory \/var\/www\/>/,/AllowOverride None/{sub("None", "All",$0)}{print}'

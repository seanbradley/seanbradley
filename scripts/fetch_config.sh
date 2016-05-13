#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

##########
#Fetch config and secrets from S3...
##########

aws s3 cp s3://grandmashouse/wp-config.php /var/www/html/wolfskill/wp-config.php

aws s3 cp s3://grandmashouse/config.sh /var/www/html/wolfskill/scripts/config.sh

sudo chmod +x /var/www/html/wolfskill/scripts/config.sh

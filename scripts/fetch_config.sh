#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

##########
#Fetch config and secrets from S3...
##########

aws s3 cp s3://grandmashouse/wp-config.php /var/www/html/wolfskill

aws s3 cp s3://grandmashouse/wolfskill_config.sh /var/www/html/wolfskill/scripts

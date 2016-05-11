#!/bin/bash

#scp -i16326633b86e9a069a1ea7a388039e34ded430ca ~/.ssh/us-west-2-keypair.pem ~/Projects/DeployPress/wp-config.php ec2-user@ec2-54-203-124-26.us-west-2.compute.amazonaws.com /var/www/html/deploypress/wp-config.php

#This file, and the files it transfers, as well as #wp-config.local.php should not be included
#in your repo once it contains actual values

echo "Transferring WordPress config..."
rsync -azv --progress --rsync-path="sudo rsync" --no-R --no-implied-dirs -e "ssh -i /home/seanbradley/.ssh/us-west-2-keypair.pem" /home/seanbradley/Projects/wolfskill/wp-config.php ec2-user@54.203.124.26:/var/www/html/wolfskill/wp-config.php

echo -e "\n"

echo "Transfering WordPress secrets and Apache config..."
rsync -azv --progress --rsync-path="sudo rsync" --no-R --no-implied-dirs -e "ssh -i /home/seanbradley/.ssh/us-west-2-keypair.pem" /home/seanbradley/Projects/wolfskill/scripts/configure_wp_secrets.sh ec2-user@54.203.124.26:/var/www/html/wolfskill/scripts/configure_wp_secrets.sh

echo "Transfering root user password for SQL set-up..."
rsync -azv --progress --rsync-path="sudo rsync" --no-R --no-implied-dirs -e "ssh -i /home/seanbradley/.ssh/us-west-2-keypair.pem" /home/seanbradley/Projects/wolfskill/scripts/configure_db.sh ec2-user@54.203.124.26:/var/www/html/wolfskill/scripts/configure_db.sh

echo -e "\n"

echo "Transfering permissions for SQL set-up and configuring tables..."
rsync -azv --progress --rsync-path="sudo rsync" --no-R --no-implied-dirs -e "ssh -i /home/seanbradley/.ssh/us-west-2-keypair.pem" /home/seanbradley/Projects/wolfskill/scripts/configure_tables.sh ec2-user@54.203.124.26:/var/www/html/wolfksill/scripts/configure_tables.sh


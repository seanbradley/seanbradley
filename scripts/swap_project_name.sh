#!/bin/bash

#replace the "*.php", "FINDSTRING" and "REPLACESTRING"
#make it executable and you are set.

#you have to use "escape-signs" ( \ ) if there are slashes 
#in the text you want to replace, so as an example: #'s/www.search.yahoo.com\/images/www.google.com\/linux/g' 
#to change www.search.yahoo.com/images to www.google.com/linux

for fl in *.*; do
mv $fl $fl.old
sed 's/deploypressdb/wolfskilldb/g' 
's/deploypressdg/wolfskilldg/g'
's/DeployPress*/wolfskill/g' $fl.old > $fl
rm -f $fl.old
done

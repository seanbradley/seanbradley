#!/bin/bash
#
#requires InstanceID, which is returned after spin_up_instances.sh,
#and/or can be fetched via describe_instances.sh

aws ec2 create-tags \
  --region us-west-2 \
  --resources i-39e1fbe1 \
  --tags Key=Name,Value=Wolfskill

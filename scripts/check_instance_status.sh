#!/bin/bash
#
#You must get the instance ID from the output of spin_up_instances.sh

aws ec2 describe-instance-status \
--region us-west-2 \
--instance-ids i-315841e9 \
--query "InstanceStatuses[*].InstanceStatus.[Status]" \
--output text 

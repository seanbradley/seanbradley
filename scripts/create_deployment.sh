#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.8." \
--github-location repository=seanbradley/wolfskill,commitId=f7f0c0068cb220f77f8ec2a50fde082fff1bc5a0
















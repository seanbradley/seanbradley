#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.3.0" \
--github-location repository=seanbradley/wolfskill,commitId=`git rev-parse HEAD` #\
--ignore-application-stop-failures

















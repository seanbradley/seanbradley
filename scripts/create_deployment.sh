#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.2.3." \
--github-location repository=seanbradley/wolfskill,commitId=`git rev-parse HEAD` #\
--ignore-application-stop-failures

















#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.2." \
--github-location repository=seanbradley/wolfskill,commitId=7caddbf5ab5f62210bc93a4db52041d55bb2e02f













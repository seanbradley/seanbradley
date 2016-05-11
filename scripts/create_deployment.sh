#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.5." \
--github-location repository=seanbradley/wolfskill,commitId=839a8dd5f516c3b6ea634dcb8459f85e509fd648














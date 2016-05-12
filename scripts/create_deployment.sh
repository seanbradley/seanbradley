#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.7." \
--github-location repository=seanbradley/wolfskill,commitId=ac213032e45a5b02cb969318f370a7595d181d45















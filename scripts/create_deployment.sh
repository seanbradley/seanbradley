#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.3." \
--github-location repository=seanbradley/wolfskill,commitId=2f69d656ed1c4646339f9a692d4b7409f8c2a00c













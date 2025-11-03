#!/bin/bash
set -e

dockerd &

while ! docker info >/dev/null 2>&1; do
  sleep 1
done

export MCSMANAGER_DEPENDENCIES_PATH=/opt/mcsmanager/daemon/lib

/opt/node-v20.12.2-linux-x64/bin/node /opt/mcsmanager/daemon/app.js &
/opt/node-v20.12.2-linux-x64/bin/node /opt/mcsmanager/web/app.js

wait

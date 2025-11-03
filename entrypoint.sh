#!/bin/bash
set -e

if [ -z "$(ls -A /opt/mcsmanager)" ]; then
    cp -r /opt/mcsmanager-data/* /opt/mcsmanager/
fi

dockerd &

while ! docker info >/dev/null 2>&1; do
  sleep 1
done

/opt/node-v20.12.2-linux-x64/bin/node /opt/mcsmanager/daemon/app.js &
/opt/node-v20.12.2-linux-x64/bin/node /opt/mcsmanager/web/app.js

wait

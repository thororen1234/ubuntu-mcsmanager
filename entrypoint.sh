#!/bin/bash
set -e

dockerd &

while ! docker info >/dev/null 2>&1; do
  sleep 1
done

cd /opt/mcsmanager/daemon &&
/opt/node-v20.12.2-linux-x64/bin/node app.js &
cd ../web &&
/opt/node-v20.12.2-linux-x64/bin/node app.js

wait

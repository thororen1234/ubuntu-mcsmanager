#!/bin/bash
set -e

CRON_JOB_LINE="0 0 * * * docker images prune -f --volumes"

(crontab -l 2>/dev/null; echo "$CRON_JOB_LINE") | crontab -

cron

dockerd &

while ! docker info >/dev/null 2>&1; do
  sleep 1
done

cd /opt/mcsmanager/daemon
node app.js &

cd /opt/mcsmanager/web
node app.js

wait

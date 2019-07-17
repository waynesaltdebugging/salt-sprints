#!/bin/sh
echo "Killing minion"
kill -INT $(cat /var/run/salt-minion.pid)
echo "Killing master"
kill -INT $(cat /var/run/salt-master.pid)

/start-services.sh

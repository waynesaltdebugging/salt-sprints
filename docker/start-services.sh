#!/bin/sh
echo "Starting minion"
salt-minion -d
echo "Starting master"
salt-master -d

until salt-key -l accepted | grep 'kevin' >/dev/null ; do
    salt-key -Ay >/dev/null
    echo "Waiting for key..."
    sleep 1
done
echo "Master and minion are up! Try 'salt \* test.version' to try things out!"

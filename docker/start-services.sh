#!/bin/sh
echo "Starting minion"
salt-minion -d
echo "Starting master"
salt-master -d

while salt-key -Ay | grep 'does not match' ; do
    echo "Waiting for key..."
    sleep 1
done
echo "Master and minion are up! Try 'salt \* test.version' to try things out!"

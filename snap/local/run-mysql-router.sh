#!/bin/bash

# While daemons must be run as non-sudo user, mysqlrouter --bootstrap needs to be
# run as root as it requires setegid privileges
exec $SNAP/usr/bin/setpriv --clear-groups --reuid root \
  --regid root -- $SNAP/usr/bin/mysqlrouter "$@"

#!/bin/bash

MYSQLD_EXPORTER_PASSWORD="$(snapctl get exporter_user_password)"

# For security measures, daemons should not be run as sudo.
# Execute mysqlrouter as the non-sudo user: snap-daemon.
exec $SNAP/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "$SNAP/bin/mysqld_exporter" \
        --collect.auto-increment.columns=false \
        --collect.info-schema.tables=false \
        --collect.info-schema.tablestats=false \
        --collect.perf-schema.indexiowaits=false \
        --collect.perf-schema.tableiowaits=false \
        --collect.perf-schema.tablelocks=false \
        --collect.info-schema.userstats=false \
        --collect.binlog-size=false \
        --collect.info-schema.processlist=false \
        --mysql.socket="$SNAP_COMMON/var/run/mysqld/mysqld.sock" \
        --mysqld.username="$(snapctl get exporter_user)" \

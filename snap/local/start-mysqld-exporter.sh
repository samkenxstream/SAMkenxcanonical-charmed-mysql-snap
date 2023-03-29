#!/bin/bash

USER="$(snapctl get exporter.user)"
PASSWORD="$(snapctl get exporter.password)"
SOCKET="$SNAP_COMMON/var/run/mysqld/mysqld.sock"

DATA_SOURCE_NAME="${USER}:${PASSWORD}@unix('${SOCKET}')"

# For security measures, daemons should not be run as sudo.
# Execute mysqlrouter as the non-sudo user: snap-daemon.
exec $SNAP/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "$SNAP/bin/mysqld_exporter" \
        --collect.auto_increment.columns=false \
        --collect.info_schema.tables=false \
        --collect.info_schema.tablestats=false \
        --collect.perf_schema.indexiowaits=false \
        --collect.perf_schema.tableiowaits=false \
        --collect.perf_schema.tablelocks=false \
        --collect.info_schema.userstats=false \
        --collect.binlog_size=false \
        --collect.info_schema.processlist=false

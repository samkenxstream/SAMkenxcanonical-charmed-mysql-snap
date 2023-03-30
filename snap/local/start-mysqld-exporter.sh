#!/bin/bash

USER="$(snapctl get exporter.user)"
PASSWORD="$(snapctl get exporter.password)"
SOCKET="$SNAP_COMMON/var/run/mysqld/mysqld.sock"

# For security measures, daemons should not be run as sudo.
# Execute mysqlrouter as the non-sudo user: snap-daemon.
$SNAP/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    env DATA_SOURCE_NAME="${USER}:${PASSWORD}@unix('${SOCKET}')" \
    "$SNAP/bin/mysqld_exporter" \
        --no-collect.auto_increment.columns \
        --no-collect.info_schema.tables \
        --no-collect.info_schema.tablestats \
        --no-collect.perf_schema.indexiowaits \
        --no-collect.perf_schema.tableiowaits \
        --no-collect.perf_schema.tablelocks \
        --no-collect.info_schema.userstats \
        --no-collect.binlog_size \
        --no-collect.info_schema.processlist

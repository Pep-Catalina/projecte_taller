#!/bin/bash

# Iniciar cron
echo "59 23 * * * /Backup_MySQL/backup.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root
crond

# Ejecutar el entrypoint original de MariaDB
exec entrypoint.sh "$@"

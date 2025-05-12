#!/bin/bash

# Crear el cronjob para el backup
echo "59 23 * * * /Backup_MySQL/backup.sh >> /var/log/cron.log 2>&1" | crontab -

# Iniciar cron en segundo plano
cron

# Ejecutar el entrypoint oficial de MariaDB (iniciará el servidor y ejecutará init.sql)
exec docker-entrypoint.sh "$@"

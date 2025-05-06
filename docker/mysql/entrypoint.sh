#!/bin/bash

# --- Colors ---
VERD="\033[32m"
VERMELL="\033[31m"
BLAU="\033[34m"
FICOLOR="\033[0m"

# --- Iniciar el servidor MariaDB en segundo plano ---
echo "{$BLAU}[INFO] Iniciant MariaDB...{$FICOLOR}"
mysqld --user=mysql --datadir=/var/lib/mysql &
sleep 10  # Esperar unos segundos para asegurar que el servidor arranca bien

# --- Asegurar que l'script de backup existeix i te permis d'execucio ---
if [ ! -x /Backup_MySQL/backup.sh ]; then
    echo "{$VERMELL}[WARN] L'script de backup existeix o no te permis d'execucio.{$FICOLOR}"
    exit 1
fi

# --- Configurar la tasca cron (es reescribeix per si es perd) ---
echo "59 23 * * * /Backup_MySQL/backup.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

# --- Iniciar cron ---
echo "{$BLAU}[INFO] Iniciant crond...{$FICOLOR}"
crond
if [ $? -ne 0 ]; then
    echo "{$VERMELL}[ERROR] No s'ha pogut iniciar crond{$FICOLOR}"
    exit 1
fi
echo "{$VERD}[OK] crond iniciat{$FICOLOR}"


#!/bin/bash

# --- Colors ---
VERD="\033[32m"
VERMELL="\033[31m"
BLAU="\033[34m"
FICOLOR="\033[0m"

# --- Conf ---
API_URL="http://localhost:8080/demanarCita"
DB_CONTAINER="mariadb-digitalitzacio"
DB_USER="status_user"
DB_PASSWORD="Educem00."

# --- Comprobacio API ---
echo -e "{$BLAU}[INFO] Comprobant API en $API_URL...{$FICOLOR}"
if curl -sf "$API_URL" > /dev/null; then
    echo "{$VERD}[OK] API OK{$FICOLOR}"
else
    echo "{$VERMELL}[ERROR] API KO{$FICOLOR}"
fi

# --- Comprobacio de la base de dades ---
echo "{$BLAU}[INFO] Comprobant l'estat de la base de dades del contenidor'$DB_CONTAINER'...{$FICOLOR}"
if docker exec "$DB_CONTAINER" mysqladmin ping -u"$DB_USER" -p"$DB_PASSWORD" --silent; then
    echo "{$VERD}[OK] DB OK{$FICOLOR}"
else
    echo "{$VERMELL}[ERROR] DB KO{$FICOLOR}"
fi

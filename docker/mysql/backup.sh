#!/bin/bash

# --- Colors ---
VERD="\033[32m"
VERMELL="\033[31m"
BLAU="\033[34m"
FICOLOR="\033[0m"

# --- Conf ---
USUARIO="gestorBackups"
PASSWORD="Educem00."
HOST="localhost"
NOMBRE_BD="centre_medic"
RUTA_COPIAS="/Backup_MySQL/"
NOMBRE_ARCHIVO="backup_"$NOMBRE_BD"_"$(date +%Y%m%d_%H%M%S)".sql.gz"

# --- Generar Copia de Seguretat---
echo -e "{$BLAU}Iniciando copia de seguridad de la base de datos '$NOMBRE_BD'...{$FICOLOR}"
mysqldump -u"$USUARIO" -p"$PASSWORD" -h"$HOST" "$NOMBRE_BD" | gzip > "$RUTA_COPIAS/$NOMBRE_ARCHIVO"

# --- Verificacio de la copia de seguretat---
if [ $? -eq 0 ]; then
    echo "{$VERD}Copia de seguretat creada correctament: $RUTA_COPIAS/$NOMBRE_ARCHIVO {$FICOLOR}"
else
    echo "{$VERMELL}Error en la creacio de la copia de seguretat.{$FICOLOR}"
    exit 1
fi
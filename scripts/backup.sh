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
RUTA_COPIAS="/Backup_MySQL"
NOMBRE_ARCHIVO="backup_${NOMBRE_BD}_$(date +%Y%m%d_%H%M%S).sql.gz"

# --- Generar Copia de Seguridad ---
echo -e "${BLAU}Iniciando copia de seguridad de la base de datos '$NOMBRE_BD'...${FICOLOR}"
mariadb-dump -u"$USUARIO" -p"$PASSWORD" -h"$HOST" "$NOMBRE_BD" | gzip > "${RUTA_COPIAS}/${NOMBRE_ARCHIVO}"

# --- Verificación de la copia de seguridad ---
if [ $? -eq 0 ]; then
    echo -e "${VERD}Copia de seguridad creada correctamente: ${RUTA_COPIAS}/${NOMBRE_ARCHIVO}${FICOLOR}"
else
    echo -e "${VERMELL}Error en la creación de la copia de seguridad.${FICOLOR}"
    exit 1
fi

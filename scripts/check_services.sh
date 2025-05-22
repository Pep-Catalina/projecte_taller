#!/bin/bash

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

# Función para comprobar si un contenedor está en ejecución
check_container() {
    CONTAINER_NAME="$1"
    if docker ps --format '{{.Names}}' | grep -qw "$CONTAINER_NAME"; then
        echo -e "${GREEN}[OK] El contenedor '$CONTAINER_NAME' està en execució.${NC}"
        return 0
    else
        echo -e "${RED}[ERROR] El contenedor '$CONTAINER_NAME' no està en execució.${NC}"
        return 1
    fi
}

# Función para comprobar la respuesta de la API con reintentos
check_api() {
    local URL="http://localhost:5000/pacients"
    local MAX_RETRIES=5
    local RETRY_DELAY=2
    local i
    local HTTP_CODE
    echo -e "${BLUE}Comprovant la resposta de l'API (${URL})...${NC}"

    for i in $(seq 1 $MAX_RETRIES); do
        HTTP_CODE=$(curl -s --noproxy localhost -o /dev/null -w "%{http_code}" "$URL")
        if [[ "$HTTP_CODE" == "200" ]]; then
            echo -e "${GREEN}[OK] L'API respon correctament.${NC}"
            return 0
        else
            echo -e "${RED}[ERROR] Intent $i: L'API no respon o retorna codi $HTTP_CODE.${NC}"
            sleep $RETRY_DELAY
        fi
    done

    echo -e "${RED}L'API no està disponible després de $MAX_RETRIES intents.${NC}"
    return 1
}

# Función para comprobar la respuesta de la base de datos MariaDB
check_database() {
    local DB_USER="status_user"
    local DB_PASS="Educem00."
    local DB_HOST="127.0.0.1"
    local DB_PORT="3366"

    echo -e "${BLUE}Comprovant la resposta de la base de dades MariaDB...${NC}"

    RESULT=$(mysql -u"$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" -e "SELECT 1;" 2>/dev/null)

    if [[ "$RESULT" == *"1"* ]]; then
        echo -e "${GREEN}[OK] La base de dades respon correctament.${NC}"
        return 0
    else
        echo -e "${RED}[ERROR] No es pot connectar a la base de dades o la consulta falla.${NC}"
        return 1
    fi
}

# Comprobación de contenedores
echo -e "${BLUE}Comprovant l'estat dels contenidors...${NC}"
check_container "nginx-digitalitzacio"
WEB_OK=$?

check_container "api-digitalitzacio"
API_CONTAINER_OK=$?

check_container "mariadb-digitalitzacio"
DB_CONTAINER_OK=$?

# Comprobación de la API
check_api
API_OK=$?

# Comprobación de la base de datos
check_database
DB_OK=$?

# Resultado final
echo -e "${BLUE}Resum final:${NC}"

if [[ $WEB_OK -eq 0 && $API_CONTAINER_OK -eq 0 && $DB_CONTAINER_OK -eq 0 && $API_OK -eq 0 && $DB_OK -eq 0 ]]; then
    echo -e "${GREEN}✅ Tot funciona correctament.${NC}"
else
    echo -e "${RED}❌ Hi ha algun servei que no funciona correctament.${NC}"
fi

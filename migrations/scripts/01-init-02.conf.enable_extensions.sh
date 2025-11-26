#!/bin/bash

# set -e

echo "Enabling extensions [POSTGRES_MULTIPLE_EXTENSIONS]: ${POSTGRES_MULTIPLE_EXTENSIONS}"

for _ext in $(echo "${POSTGRES_MULTIPLE_EXTENSIONS}" | tr ',' ' '); do
  echo "extension: [${_ext}]"
  PGUSER="${POSTGRES_USER}" PGDATABASE="${POSTGRES_DB}" \
    psql -v ON_ERROR_STOP=1 -c "CREATE EXTENSION IF NOT EXISTS \"${_ext}\";"
done

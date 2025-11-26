#!/bin/bash

# set -e

echo "Securing pg_hba.conf"

resolved_user="${POSTGRES_USER:-$(cat ${POSTGRES_USER_FILE})}"
resolved_db="${POSTGRES_DB:-$(cat ${POSTGRES_DB_FILE})}"

cp "$PGDATA/pg_hba.conf" "$PGDATA/pg_hba.conf.orig"
# : > "$PGDATA/pg_hba.conf"
truncate --size 0 "$PGDATA/pg_hba.conf"

# Via CLI:
echo "local   ${resolved_db}  ${resolved_user}  trust"  >> "$PGDATA/pg_hba.conf"
echo "local   all             all               reject" >> "$PGDATA/pg_hba.conf"

# Via network:
echo "host    ${resolved_db}  ${resolved_user}  127.0.0.0/8   scram-sha-256" >> "$PGDATA/pg_hba.conf"
# echo "host    ${resolved_db}  ${resolved_user}  10.0.0.0/8   scram-sha-256" >> "$PGDATA/pg_hba.conf"
echo "host    ${resolved_db}  ${resolved_user}  10.88.0.0/16   scram-sha-256" >> "$PGDATA/pg_hba.conf"
echo "host    ${resolved_db}  ${resolved_user}  10.89.0.0/16   scram-sha-256" >> "$PGDATA/pg_hba.conf"
echo "host    all             all               0.0.0.0/0     reject"        >> "$PGDATA/pg_hba.conf"

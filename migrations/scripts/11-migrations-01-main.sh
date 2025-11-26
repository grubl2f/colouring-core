#!/usr/bin/env bash

# =============================================================================
# /docker-entrypoint-initdb.d/11-migrations-*.sh
# =============================================================================
# Must be world‐readable but NOT executable (0644), so that it's SOURCED
# by docker-entrypoint.sh rather than run in a subshell.
# =============================================================================

# set -euo pipefail

# =============================================================================
# Migrations: main
# =============================================================================
echo "📥 Run DB migrations"
# EXCLUDED_PATTERN='^.*/05(1|7|8).*$'
EXCLUDED_PATTERN='^.*/.*\..sql\.__DISABLED__$'
MIGRATIONS_DIR="/app/migrations"

cd "${MIGRATIONS_DIR}"
# MIGRATION_FILES=$(find "$MIGRATIONS_DIR" -maxdepth 1 -type f -name "*.up.sql" | grep -Ev "$EXCLUDED_PATTERN")
# mapfile -t MIGRATION_FILES < <(find "$MIGRATIONS_DIR" -maxdepth 1 -type f -name "*.up.sql" | grep -Ev "$EXCLUDED_PATTERN")
mapfile -t MIGRATION_FILES < <(find . -maxdepth 1 -type f -name "*.up.sql" | grep -Ev "$EXCLUDED_PATTERN" | sort -u )
ls -la ./
echo "MIGRATION_FILES = ${MIGRATION_FILES[@]}"
docker_process_init_files "${MIGRATION_FILES[@]}"
cd -

unset EXCLUDED_PATTERN MIGRATIONS_DIR MIGRATION_FILES
echo "✅ 📥 Done DB migrations"
# =============================================================================

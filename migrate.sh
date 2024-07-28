#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DB_URL="postgres://localhost:5432/postgres?sslmode=disable"
MIGRATIONS_DIR="${SCRIPT_DIR}/internal/database/migrations"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

print_usage() {
    echo -e "${YELLOW}usage: $0 <up|down> [number_of_migrations]${NC}"
    echo "  up   : apply migrations"
    echo "  down : revert migrations"
    echo "  number_of_migrations: optional. number of migrations to apply or revert."
}

if ! command -v migrate &> /dev/null; then
    echo -e "${RED}error: golang-migrate is not installed.${NC}"
    echo "please install it from: https://github.com/golang-migrate/migrate"
    exit 1
fi

if [ ! -d "$MIGRATIONS_DIR" ]; then
    echo -e "${RED}error: migrations directory not found: $MIGRATIONS_DIR${NC}"
    echo "please ensure the migrations are in the correct location relative to this script."
    exit 1
fi

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    print_usage
    exit 1
fi

direction=$1
if [ "$direction" != "up" ] && [ "$direction" != "down" ]; then
    echo -e "${RED}error: invalid direction. use 'up' or 'down'.${NC}"
    print_usage
    exit 1
fi

cmd="migrate -source file://$MIGRATIONS_DIR -database \"$DB_URL\" $direction"

if [ $# -eq 2 ]; then
    if ! [[ $2 =~ ^[0-9]+$ ]]; then
        echo -e "${RED}error: number of migrations must be a positive integer.${NC}"
        exit 1
    fi
    cmd+=" $2"
fi

echo -e "${GREEN}running migration: $direction${NC}"
echo -e "${YELLOW}using migrations from: $MIGRATIONS_DIR${NC}"
if eval $cmd; then
    echo -e "${GREEN}migration completed successfully!${NC}"
else
    echo -e "${RED}migration failed. please check the error message above :(${NC}"
    exit 1
fi
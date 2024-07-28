#!/bin/bash
# requires that you have golang-migrate installed
# https://github.com/golang-migrate/migrate?tab=readme-ov-file

# $1 = up or down
migrate -source file://database/migrations -database "postgres://localhost:5432/postgres?sslmode=disable" $1 
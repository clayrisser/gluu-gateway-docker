#!/bin/sh

sleep 5
psql -h "$DB_HOST" -U "$DB_USER" -c "CREATE DATABASE $DB_DATABASE;"
psql -h "$DB_HOST" -U "$DB_USER" $DB_DATABASE < /opt/app/konga_db.sql

exec node /opt/app/start.js "$@"

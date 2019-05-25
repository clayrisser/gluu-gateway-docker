#!/bin/sh

sleep 5
if [ ! $(psql -h "$DB_HOST" -U "$DB_USER" -l | cut -d \| -f 1 | grep -w $DB_DATABASE) ]; then
  psql -h "$DB_HOST" -U "$DB_USER" -c "CREATE DATABASE $DB_DATABASE;"
fi
if [ ! $(psql -h "$DB_HOST" -U "$DB_USER" -c "\c $DB_DATABASE" -c "\dt" | cut -d \| -f 2 | grep -w konga_api_health_checks) ]; then
  psql -h "$DB_HOST" -U "$DB_USER" $DB_DATABASE < /opt/app/konga_db.sql
fi

exec sh /opt/app/start.sh "$@"

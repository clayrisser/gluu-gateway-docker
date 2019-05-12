#!/bin/sh

mkdir -p /certs
if [ ! -f "$KEY_PATH" ]; then
  openssl genrsa -out "$KEY_PATH" 2048
fi
if [ ! -f "$CERT_PATH" ]; then
  openssl req -x509 -key "$KEY_PATH" -out "$CERT_PATH" -subj \
          "/C=$COUNTRY_NAME/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION_NAME/CN=$COMMON_NAME/emailAddress=$EMAIL"
fi

sleep 5
psql -h "$DB_HOST" -U "$DB_USER" -c "CREATE DATABASE $DB_DATABASE;"
psql -h "$DB_HOST" -U "$DB_USER" $DB_DATABASE < /opt/app/konga_db.sql

exec /bin/sh /opt/app/start.sh "$@"

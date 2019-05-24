#!/bin/sh

mkdir -p /certs
if [ ! -f "$KEY_PATH" ]; then
  openssl genrsa -out "$KEY_PATH" 2048
fi
if [ ! -f "$CERT_PATH" ]; then
  openssl req -x509 -key "$KEY_PATH" -out "$CERT_PATH" -subj \
          "/C=$COUNTRY_NAME/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION_NAME/CN=$COMMON_NAME/emailAddress=$EMAIL"
fi

confd -onetime -backend env

sleep 5
if [ ! $(psql -h "$KONG_PG_HOST" -U "$KONG_PG_USER" -l | cut -d \| -f 1 | grep -qw $KONG_PG_DATABASE) ]; then
  psql -h "$KONG_PG_HOST" -U "$KONG_PG_USER" -c "CREATE DATABASE $KONG_PG_DATABASE;"
fi
if [ ! $(psql -h "$KONG_PG_HOST" -U "$KONG_PG_USER" -c "\c $KONG_PG_DATABASE" -c "\dt" | cut -d \| -f 2 | grep -qw profiles) ]; then
  /docker-entrypoint.sh kong migrations up
fi

exec /docker-entrypoint.sh "$@"

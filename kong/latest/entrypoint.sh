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
psql -h "$KONG_PG_HOST" -U "$KONG_PG_USER" -c "CREATE DATABASE $KONG_PG_DATABASE;"
/docker-entrypoint.sh kong migrations bootstrap

exec /docker-entrypoint.sh "$@"

#!/bin/sh

mkdir -p /certs
if [ ! -f "$KEY_PATH" ]; then
  openssl genrsa -out "$KEY_PATH" 2048
fi
if [ ! -f "$CERT_PATH" ]; then
  openssl req -x509 -key "$KEY_PATH" -out "$CERT_PATH" -subj \
          "/C=$COUNTRY_NAME/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION_NAME/CN=$COMMON_NAME/emailAddress=$EMAIL"
fi

exec /bin/sh /opt/app/start.sh "$@"

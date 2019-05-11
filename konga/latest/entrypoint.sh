#!/bin/sh

openssl genrsa -out config/tls.key 2048
openssl req -x509 -key config/tls.key -out config/tls.crt -subj \
        "/C=$COUNTRY_NAME/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION_NAME/CN=$COMMON_NAME/emailAddress=$EMAIL"

exec /bin/sh /opt/app/start.sh "$@"

#!/bin/sh

openssl genrsa -des3 -out key.orig -passout pass:pass 2048
openssl rsa -in key.orig -passin pass:pass -out key.pem
openssl req -new -key key.pem -out cert.csr -subj \
        "/C=US/ST=TX/L=Austin/O=CodeJamNinja/CN=CodeJamNinja/emailAddress=tech@codejam.ninja"
openssl x509 -req -days 365 -in cert.csr -signkey key.pem -out cert.pem

exec /bin/sh /opt/app/start.sh "$@"

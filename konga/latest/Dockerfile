FROM node:8.16.0-alpine

LABEL image=codejamninja/gg-konga:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.9

WORKDIR /tmp

RUN apk add --no-cache --virtual build-deps \
  git
RUN apk add --no-cache \
  ca-certificates \
  openssl \
  postgresql-client \
  tini
RUN git clone https://github.com/GluuFederation/gluu-gateway.git && \
  cd gluu-gateway/konga && \
  yarn && \
  mv /tmp/gluu-gateway/konga /opt/app

COPY local.js /opt/app/config/local.js
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/gluu-gateway && \
  apk del build-deps

WORKDIR /opt/app

ENV CLIENT_ID="" \
  CLIENT_SECRET="" \
  CERT_PATH=/certs/tls.crt \
  COMMON_NAME=gluu.com \
  COUNTRY_NAME=US \
  DB_DATABASE=konga \
  DB_HOST=postgres \
  DB_PASSWORD=postgres \
  DB_PORT=5432 \
  DB_SSL=false \
  DB_USER=postgres \
  EMAIL=email@example.com \
  EXPLICIT_HOST=localhost \
  GG_VERSION=1.0 \
  KEY_PATH=/certs/tls.key \
  KONG_ADMIN_URL=http://kong:8001 \
  LOCALITY=Austin \
  NODE_ENV=production \
  OP_HOST=http://op:8080 \
  ORGANIZATION_NAME=Gluu \
  OXD_ID= \
  OXD_VERSION=4.0 \
  OXD_WEB=http://oxd:8443 \
  PORT=1338 \
  SECRET=some-secret \
  STATE=TX

EXPOSE 1338

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]

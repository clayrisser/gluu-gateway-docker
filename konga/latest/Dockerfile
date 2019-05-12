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
  yarn add cross-spawn && \
  yarn add node-fetch && \
  mv /tmp/gluu-gateway/konga /opt/app

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY konga_db.sql /opt/app/konga_db.sql
COPY local.js /opt/app/config/local.js
COPY start.js /opt/app/start.js

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/gluu-gateway && \
  apk del build-deps

WORKDIR /opt/app

ENV BASE_URL=https://localhost:1338 \
  COMMON_NAME=gluu.com \
  COUNTRY_NAME=US \
  DB_DATABASE=konga \
  DB_HOST=postgres \
  DB_PASSWORD=postgres \
  DB_PORT=5432 \
  DB_SSL=false \
  DB_USER=postgres \
  EMAIL=email@example.com \
  GG_VERSION=1.0 \
  KONG_ADMIN_URL=http://kong:8001 \
  LOCALITY=Austin \
  NODE_ENV=production \
  OP_HOST=https://op:8080 \
  ORGANIZATION_NAME=Gluu \
  OXD_VERSION=4.0 \
  OXD_WEB=https://oxd:8443 \
  PORT=1338 \
  SECRET=some-secret \
  STATE=TX

EXPOSE 1338

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]

FROM openjdk:8-jre-alpine3.9

LABEL image=codejamninja/oxd:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.9

WORKDIR /tmp

RUN apk add --no-cache --virtual build-deps \
  curl
RUN apk add --no-cache \
  tini
RUN curl -L -o /usr/local/bin/confd \
  https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && \
  chmod +x /usr/local/bin/confd

WORKDIR /opt/oxd-server

RUN curl -LO http://ox.gluu.org/maven/org/xdi/oxd-server/4.0-SNAPSHOT/oxd-server-4.0-SNAPSHOT.jar && \
  curl -LO http://ox.gluu.org/maven/org/bouncycastle/bcprov-jdk15on/1.54/bcprov-jdk15on-1.54.jar && \
  curl -LO https://github.com/GluuFederation/oxd/raw/version_4.0/oxd-server/src/main/resources/oxd-server.keystore

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY oxd-conf.yml.tmpl /etc/confd/templates/oxd-conf.yml.tmpl
COPY oxd.toml /etc/confd/conf.d/oxd.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/* && \
  apk del build-deps

ENV ACR_VALUES="['']" \
  ADMIN_CONNECTOR_HTTPS_PORT=8444 \
  ADMIN_KEYSTORE_PASSWORD=example \
  ADMIN_KEYSTORE_PATH=/opt/oxd-server/oxd-server.keystore \
  ADMIN_KEYSTORE_VALIDATE_CERTS=false \
  APPLICATION_CONNECTOR_HTTPS_PORT=8443 \
  APPLICATION_KEYSTORE_PASSWORD=example \
  APPLICATION_KEYSTORE_PATH=/opt/oxd-server/oxd-server.keystore \
  APPLICATION_KEYSTORE_VALIDATE_CERTS=false \
  CLAIMS_LOCALES="['en']" \
  CONTACTS="[]" \
  CRYPT_PROVIDER_DN_NAME="" \
  CRYPT_PROVIDER_KEY_STORE_PASSWORD="" \
  CRYPT_PROVIDER_KEY_STORE_PATH="" \
  DB_FILE_LOCATION=/opt/oxd-server/data/oxd_db \
  GRANT_TYPE="['authorization_code']" \
  MIGRATION_SOURCE_FOLDER_PATH="" \
  NONCE_EXPIRATION_IN_MINUTES=5 \
  OP_DISCOVERY_PATH="" \
  OP_HOST=https://accounts.gluu.org/oxauth \
  PROTECT_COMMANDS_WITH_ACCESS_TOKEN=true \
  PUBLIC_OP_KEY_CACHE_EXPIRATION_IN_MINUTES=60 \
  RESPONSE_TYPES="['code']" \
  SCOPE="['openid', 'profile', 'email']" \
  STATE_EXPIRATION_IN_MINUTES=5 \
  STORAGE=h2 \
  SUPPORT_GOOGLE_LOGOUT=true \
  TRUST_STORE_PASSWORD="" \
  UI_LOCALES="['en']" \
  UMA2_AUTO_REGISTER_CLAIMS_GATHERING_ENDPOINT_AS_REDIRECT_URI_OF_CLIENT=true

EXPOSE 8443 8444

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]

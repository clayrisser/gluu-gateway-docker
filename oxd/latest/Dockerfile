FROM ubuntu:16.04

LABEL image=codejamninja/gg-kong:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=ubuntu:16.04

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  curl \
  openjdk-8-jre
RUN echo "deb https://repo.gluu.org/ubuntu/ xenial main" > /etc/apt/sources.list.d/gluu-repo.list && \
  curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add - && \
  apt-get update && apt-get install -y \
  oxd-server
RUN curl -L -o tini.deb http://archive.ubuntu.com/ubuntu/pool/universe/t/tini/tini_0.18.0-1_amd64.deb && \
  dpkg -i tini.deb
RUN curl -L -o /usr/local/bin/confd \
  https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && \
  chmod +x /usr/local/bin/confd

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY oxd-conf.json.tmpl /etc/confd/templates/oxd-conf.json.tmpl
COPY oxd.toml /etc/confd/conf.d/oxd.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/*

ENV ADMIN_CONNECTOR_HTTPS_PORT="" \
  ADMIN_KEYSTORE_PASSWORD="" \
  ADMIN_KEYSTORE_PATH="" \
  ADMIN_KEYSTORE_VALIDATE_CERTS="" \
  APPLICATION_CONNECTOR_HTTPS_PORT="" \
  APPLICATION_KEYSTORE_PASSWORD="" \
  APPLICATION_KEYSTORE_PATH="" \
  APPLICATION_KEYSTORE_VALIDATE_CERTS="" \
  ARCHIVED_FILE_COUNT="" \
  CRYPT_PROVIDER_DN_NAME="" \
  CRYPT_PROVIDER_KEY_STORE_PASSWORD="" \
  CRYPT_PROVIDER_KEY_STORE_PATH="" \
  CURRENT_LOG_FILENAME="" \
  DB_FILE_LOCATION="" \
  DEFAULT_SITE_CONFIG_ACR_VALUES="" \
  DEFAULT_SITE_CONFIG_CLAIMS_LOCALES="" \
  DEFAULT_SITE_CONFIG_CONTACTS="" \
  DEFAULT_SITE_CONFIG_GRANT_TYPES="" \
  DEFAULT_SITE_CONFIG_RESPONSE_TYPES="" \
  DEFAULT_SITE_CONFIG_SCOPE="" \
  DEFAULT_SITE_CONFIG_UI_LOCALES="" \
  GLUU_LOG_LEVEL="" \
  MAX_FILE_SIZE="" \
  MIGRATION_SOURCE_FOLDER_PATH="" \
  NONCE_EXPIRATION_IN_MINUTES="" \
  PROTECT_COMMANDS_WITH_ACCESS_TOKEN="" \
  PUBLIC_OP_KEY_CACHE_EXPIRATION_IN_MINUTES="" \
  STATE_EXPIRATION_IN_MINUTES="" \
  STORAGE="" \
  SUPPORT_GOOGLE_LOGOUT="" \
  THRESHOLD="" \
  TIME_ZONE="" \
  TRUST_STORE_PASSWORD="" \
  UMA2_AUTO_REGISTER_CLAIMS_GATHERING_ENDPOINT_AS_REDIRECT_URI_OF_CLIENT="" \
  XDI_LOG_LEVEL=""

EXPOSE 8443 8444

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/sbin/entrypoint.sh"]
CMD ["hello", "world"]

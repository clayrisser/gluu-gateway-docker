FROM kong:1.1.2-alpine

LABEL image=codejamninja/gg-kong:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.6

WORKDIR /tmp

RUN apk add --no-cache --virtual build-deps \
  git
RUN apk add --no-cache \
  ca-certificates \
  openssl \
  postgresql-client \
  tini
RUN curl -L -o /usr/local/bin/confd \
  https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && \
  chmod +x /usr/local/bin/confd
RUN git clone https://github.com/GluuFederation/gluu-gateway.git

WORKDIR /

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY kong.conf.tmpl /etc/confd/templates/kong.conf.tmpl
COPY kong.toml /etc/confd/conf.d/kong.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/gluu-gateway && \
  apk del build-deps

ENV CERT_PATH=/certs/tls.crt \
  COMMON_NAME=gluu.com \
  COUNTRY_NAME=US \
  EMAIL=email@example.com \
  KEY_PATH=/certs/tls.key \
  KONG_DATABASE=postgres \
  KONG_PG_DATABASE=kong \
  KONG_PG_HOST=postgres \
  KONG_PG_PASSWORD=postgres \
  KONG_PG_PORT=5432 \
  KONG_PG_USER=postgres \
  LOCALITY=Austin \
  ORGANIZATION_NAME=Gluu \
  STATE=TX

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]
CMD ["kong", "docker-start"]

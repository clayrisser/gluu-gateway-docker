FROM kong:0.14.1-alpine

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
RUN git clone https://git.rucciva.one/rucciva/json-logic-lua.git && \
  git clone https://github.com/GluuFederation/gluu-gateway.git && \
  git clone https://github.com/GluuFederation/oxd-web-lua.git && \
  git clone https://github.com/altexy/lua-resty-jwt.git && \
  git clone https://github.com/jkeys089/lua-resty-hmac.git && \
  git clone https://github.com/knyar/nginx-lua-prometheus.git && \
  git clone https://github.com/openresty/lua-resty-lrucache.git && \
  mkdir -p lua/gluu lua/kong/plugins lua/resty lua/rucciva && \
  cp -r gluu-gateway/kong/plugins/* lua/kong/plugins && \
  cp -r lua-resty-hmac/lib/resty/* lua/resty && \
  cp -r lua-resty-jwt/lib/resty/* lua/resty && \
  cp -r lua-resty-lrucache/lib/resty/* lua/resty && \
  cp gluu-gateway/kong/common/kong-auth-pep-common.lua lua/gluu && \
  cp json-logic-lua/logic.lua lua/rucciva/json_logic.lua && \
  cp nginx-lua-prometheus/prometheus.lua lua/prometheus.lua && \
  cp oxd-web-lua/oxdweb.lua lua/gluu/oxdweb.lua && \
  cd lua/kong/plugins && \
  rm -rf ldap-auth key-auth basic-auth jwt oauth2 hmac-auth && \
  cp -r /tmp/lua/* /usr/local/share/lua/5.1

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY kong.conf.tmpl /etc/confd/templates/kong.conf.tmpl
COPY kong.toml /etc/confd/conf.d/kong.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/* && \
  apk del build-deps

WORKDIR /

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

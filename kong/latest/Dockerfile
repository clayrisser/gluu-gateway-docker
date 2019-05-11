FROM kong:1.1.2-alpine

LABEL image=codejamninja/gg-kong:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.6

RUN apk add --no-cache \
  tini
RUN curl -L -o /usr/local/bin/confd \
  https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && \
  chmod +x /usr/local/bin/confd

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY kong.conf.tmpl /etc/confd/templates/kong.conf.tmpl
COPY kong.toml /etc/confd/conf.d/kong.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh

ENV KONG_DATABASE=postgres \
  KONG_PG_DATABASE=postgres \
  KONG_PG_HOST=postgres \
  KONG_PG_PASSWORD=postgres \
  KONG_PG_PORT=5432 \
  KONG_PG_USER=postgres

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]
CMD ["kong", "docker-start"]

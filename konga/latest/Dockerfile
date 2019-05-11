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
  tini
RUN git clone https://github.com/GluuFederation/gluu-gateway.git && \
  cd gluu-gateway/konga && \
  yarn && \
  mv /tmp/gluu-gateway/konga /opt/app

WORKDIR /opt/app

COPY local.js /opt/app/local.js
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /usr/local/sbin/entrypoint.sh && \
  rm -rf /tmp/gluu-gateway && \
  apk del build-deps

ENV DB_DATABASE=postgres
ENV DB_HOST=postgres
ENV DB_PASSWORD=postgres
ENV DB_PORT=5432
ENV DB_USER=postgres
ENV NODE_ENV=production

EXPOSE 1338

ENTRYPOINT ["/sbin/tini", "--", "sh", "-c", "/usr/local/sbin/entrypoint.sh"]

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

ENV CLIENT_ID=""
ENV CLIENT_SECRET=""
ENV COMMON_NAME=gluu.com
ENV COUNTRY_NAME=US
ENV DB_DATABASE=konga
ENV DB_HOST=postgres
ENV DB_PASSWORD=postgres
ENV DB_PORT=5432
ENV DB_SSL=false
ENV DB_USER=postgres
ENV EMAIL=email@example.com
ENV EXPLICIT_HOST=localhost
ENV GG_VERSION=1.0
ENV KONG_ADMIN_URL=http://kong:8001
ENV LOCALITY=Austin
ENV NODE_ENV=production
ENV OP_HOST=http://op:8080
ENV ORGANIZATION_NAME=Gluu
ENV OXD_ID=
ENV OXD_VERSION=4.0
ENV OXD_WEB=http://oxd:8443
ENV PORT=1338
ENV SECRET=some-secret
ENV STATE=TX

EXPOSE 1338

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]

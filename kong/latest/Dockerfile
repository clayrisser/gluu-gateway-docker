FROM kong:1.1.2-alpine

LABEL image=codejamninja/gg-kong:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.6

RUN apk add --no-cache \
  tini

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /usr/local/sbin/entrypoint.sh

ENV KONG_DATABASE=postgres
ENV KONG_PG_DATABASE=postgres
ENV KONG_PG_HOST=postgres
ENV KONG_PG_PASWORD=postgres
ENV KONG_PG_USER=postgres

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/entrypoint.sh"]
CMD ["kong", "docker-start"]

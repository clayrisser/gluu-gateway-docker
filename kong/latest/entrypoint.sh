#!/bin/sh

sleep 5
/docker-entrypoint.sh kong migrations bootstrap

exec /docker-entrypoint.sh "$@"

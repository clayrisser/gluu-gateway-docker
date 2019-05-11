#!/bin/sh

confd -onetime -backend env

sleep 5
/docker-entrypoint.sh kong migrations bootstrap

exec /docker-entrypoint.sh "$@"

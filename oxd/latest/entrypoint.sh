#!/bin/sh

confd -onetime -backend env
/etc/init.d/oxd-server start

exec tail -f /dev/null

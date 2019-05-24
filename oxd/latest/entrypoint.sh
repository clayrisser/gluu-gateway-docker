#!/bin/sh

confd -onetime -backend env

exec java -Djava.net.preferIPv4Stack=true -cp bcprov-jdk15on-1.54.jar:oxd-server-4.0-SNAPSHOT.jar org.xdi.oxd.server.OxdServerApplication server /opt/oxd-server/oxd-server.yml

#!/bin/bash

set -ex

if [ "$EXPORT_REALM" == "true" ]; then
  mkdir -p /tmp/realm-export
  export KEYCLOAK_EXTRA_ARGS="-Dkeycloak.migration.action=export -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=/tmp/realm-export"
else
  mkdir -p /tmp/realm-config
  dockerize -template /realm-config:/tmp/realm-config

  cd /tmp/realm-config
  for file in *
  do
    mv $file $REALM-$file
  done
  cd -

  export KEYCLOAK_EXTRA_ARGS="-Dkeycloak.migration.action=import -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=/tmp/realm-config -Dkeycloak.migration.strategy=IGNORE_EXISTING"
fi

exec "$@"

#!/bin/sh

set -ex

mkdir -p /tmp/realm-config
dockerize -template /realm-config:/tmp/realm-config

cd /tmp/realm-config

for file in *
do
  mv $file $REALM-$file
done

cd -
exec "$@"

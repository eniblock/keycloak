#!/bin/sh

echo

set -e

cd /tf
d=`mktemp -d`

# copy the file in a tempdir, so we don't have to touch the files
cp -a /tf/ $d/

cd $d/tf

# link the files in /tf/files, that comes from the config map, to /tf
for f in `ls $d/tf/files`; do
    ln -sf $d/tf/files/$f $f
done

export TF_IN_AUTOMATION=true
dockerize -timeout 60s -wait tcp://$KC_DB_URL_HOST:$KC_DB_URL_PORT
terraform init -no-color --backend-config="conn_str=postgres://$KC_DB_USERNAME:$KC_DB_PASSWORD@$KC_DB_URL_HOST:$KC_DB_URL_PORT/$KC_DB_URL_DATABASE?sslmode=disable"
dockerize -timeout 60s -wait http://localhost:8080/auth/health
export TF_VAR_admin_username=$KEYCLOAK_ADMIN
export TF_VAR_admin_password=$KEYCLOAK_ADMIN_PASSWORD
terraform apply -no-color --auto-approve -lock-timeout=60s

cd /tf
rm -rf $d

echo

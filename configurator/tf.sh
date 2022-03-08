#!/bin/sh

set -ex

function waitport {
    until printf "" 2>>/dev/null >>/dev/tcp/$1/$2; do
        echo waiting for $1:$2 > /dev/stderr
        sleep 1;
    done
}

cd /tf
waitport $KC_DB_URL_HOST $KC_DB_URL_PORT
terraform init -no-color --backend-config="conn_str=postgres://$KC_DB_USERNAME:$KC_DB_PASSWORD@$KC_DB_URL_HOST:$KC_DB_URL_PORT/$KC_DB_URL_DATABASE?sslmode=disable"
waitport localhost 8080
terraform apply -no-color --auto-approve

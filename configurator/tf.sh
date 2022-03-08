#!/bin/sh

set -ex

cd /tf
dockerize -timeout 60s -wait tcp://$KC_DB_URL_HOST:$KC_DB_URL_PORT
terraform init -no-color --backend-config="conn_str=postgres://$KC_DB_USERNAME:$KC_DB_PASSWORD@$KC_DB_URL_HOST:$KC_DB_URL_PORT/$KC_DB_URL_DATABASE?sslmode=disable"
dockerize -timeout 60s -wait http://localhost:8080/auth/health
export TF_VAR_admin_username=$KEYCLOAK_ADMIN
export TF_VAR_admin_password=$KEYCLOAK_ADMIN_PASSWORD
terraform apply -no-color --auto-approve

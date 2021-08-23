#!/usr/bin/env python

config.define_bool("no-volumes")
cfg = config.parse()

docker_build("registry.gitlab.com/the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/keycloak", ".")

k8s_yaml(
    helm(
        'helm/keycloak',
        values=['./helm/keycloak/values-dev.yaml'],
        name="keycloak",
    )
)

k8s_resource('keycloak', port_forwards=['9080:8080', '9443:8443'])

if config.tilt_subcommand == 'down' and not cfg.get("no-volumes"):
  local('kubectl --context ' + k8s_context() + ' delete pvc --selector=app.kubernetes.io/instance=keycloak --wait=false')

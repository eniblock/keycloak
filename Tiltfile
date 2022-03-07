#!/usr/bin/env python

config.define_bool("no-volumes")
cfg = config.parse()

clk_k8s = 'clk --force-color k8s -c ' + k8s_context() + ' '

if config.tilt_subcommand == 'up':
    local(clk_k8s + 'add-domain kc.localhost')
    local(clk_k8s + 'helm-dependency-update helm/keycloak')

docker_build("registry.gitlab.com/the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/keycloak", ".")

k8s_yaml(
    helm(
        'helm/keycloak',
        values=['./helm/keycloak/values-dev.yaml'],
        name="keycloak",
    )
)

if config.tilt_subcommand == 'down' and not cfg.get("no-volumes"):
  local('kubectl --context ' + k8s_context() + ' delete pvc --selector=app.kubernetes.io/instance=keycloak --wait=false')

#!/usr/bin/env python

config.define_bool("no-volumes")
cfg = config.parse()

clk_k8s = 'clk --force-color k8s -c ' + k8s_context() + ' '

if config.tilt_subcommand == 'up':
    local(clk_k8s + 'add-domain kc.localhost')
    local(clk_k8s + 'helm-dependency-update helm/keycloak')

custom_build(
    'eniblock/keycloak',
    'earthly +docker --ref=$EXPECTED_REF',
    ['.'],
    live_update=[
        sync('configurator/', '/tf/'),
        sync('theme/', '/opt/keycloak/themes/extra/'),
    ],
)

k8s_yaml(
    helm(
        'helm/keycloak',
        values=['./helm/keycloak/values-dev.yaml'],
        name="keycloak",
    )
)

k8s_resource('keycloak', port_forwards=['8080:8080'])
k8s_resource('keycloak-keycloak-db', port_forwards=['5432:5432'])
local_resource('helm lint',
               'docker run --rm -t -v $PWD:/app registry.gitlab.com/xdev-tech/build/helm:3.0' +
               ' lint keycloak helm/keycloak --values helm/keycloak/values-dev.yaml',
               'helm/keycloak/', allow_parallel=True)

if config.tilt_subcommand == 'down' and not cfg.get("no-volumes"):
    local('kubectl --context ' + k8s_context() + ' delete pvc --selector=app.kubernetes.io/instance=keycloak --wait=false')

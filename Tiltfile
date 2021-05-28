#!/usr/bin/env python

docker_build("registry.gitlab.com/the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/keycloak", ".")
k8s_yaml(
    helm(
        'helm/keycloak',
        name="keycloak",
    )
)

k8s_resource('keycloak', port_forwards=['9080:80', '9443:443'])

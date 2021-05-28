#!/usr/bin/env python
load('ext://helm_remote', 'helm_remote')
docker_build("registry.gitlab.com/the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/keycloak", ".")
helm_remote('keycloak',
    repo_url="https://charts.bitnami.com/bitnami",
    version="2.4.3",
    values=["values.yaml"],
)
k8s_resource('keycloak', port_forwards=['9080:8080', '9443:8443'])

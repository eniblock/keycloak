[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-white.svg)](https://sonarcloud.io/dashboard?id=the-blockchain-xdev_keycloak)  [![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=the-blockchain-xdev_keycloak&metric=reliability_rating&token=de383d64f8731f96177a65b5f1e8e42bfcabc947)](https://sonarcloud.io/dashboard?id=the-blockchain-xdev_keycloak)

Xdev's customized keycloak image to use with bitnami's helm chart

## Usage

Add it as dependency in your `Chart.yml`

~~~yaml
dependencies:
  - name: keycloak
    version: "2.4.3"
    repository: "oci://registry.gitlab.com/the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/helm"
~~~

and configure it in `values.yaml` to get the image from this gitlab repository

~~~yaml
image:
  registry: registry.gitlab.com
  repository: the-blockchain-xdev/xdev-product/enterprise-business-network/keycloak/keycloak
  tag: develop
  pullSecrets:
    - gitlab-registry
~~~

make sure the pull secret is configured with a gitlab access token with the `read_registry` scope

~~~bash
kubectl create secret docker-registry gitlab-registry \
  --docker-server=registry.gitlab.com \
  --docker-username=your_user \
  --docker-password=your_token
~~~

## Export realm configuration

Set the environment variable `EXPORT_REALM` to `true` on the keycloak pod:

~~~yaml
extraEnvVars:
  - name: EXPORT_REALM
    value: "true"
~~~

The export is available in `/tmp/realm-export` in the keycloak pod. The content can be retrieved with

~~~bash
kubectl exec keycloak-0 -- tar cv /tmp/realm-export > /tmp/realm-export.tgz
~~~

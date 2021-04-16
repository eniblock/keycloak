Xdev's customized keycloak image to use with bitnami's helm chart

## Usage

Add it as dependency in your `Chart.yml`

~~~yaml
dependencies:
  - name: keycloak
    version: "2.4.4"
    repository: "https://charts.bitnami.com/bitnami"
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
kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=your_user --docker-password=your_token
~~~

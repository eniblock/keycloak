[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=bugs)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=code_smells)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=coverage)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=duplicated_lines_density)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=ncloc)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=alert_status)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=reliability_rating)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=security_rating)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=sqale_index)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=xdev-tech_keycloak&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=xdev-tech_keycloak)

Xdev's customized keycloak image to use with bitnami's helm chart

## Usage

### Standard

For stable (tagged) versions:

```
helm repo add hlf-k8s https://gitlab.com/api/v4/projects/30585617/packages/helm/stable
helm search repo keycloak
```

For development versions:

```
helm repo add hlf-k8s https://gitlab.com/api/v4/projects/30585617/packages/helm/dev
helm search repo keycloak --devel
```

### OCI

Add it as dependency in your `Chart.yml`

~~~yaml
dependencies:
  - name: keycloak
    version: "2.4.3"
    repository: "oci://xdev-tech/xdev-enterprise-business-network/keycloak/helm"
~~~

and configure it in `values.yaml` to get the image from this gitlab repository

~~~yaml
image:
  registry: registry.gitlab.com
  repository: xdev-tech/xdev-enterprise-business-network/keycloak
  tag: 0.2.0
  imagePullSecrets:
    - name: gitlab-registry
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
kubectl exec keycloak-0 -- tar cv /tmp/realm-export > /tmp/realm-export.tar
~~~

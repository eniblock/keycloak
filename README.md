Eniblock's customized keycloak image and helm chart

## Usage

### Standard

```
helm install oci://github.com/eniblock/keycloak --version docker pull ghcr.io/eniblock/keycloak:0.3.0-develop.4
```

### OCI

Add it as dependency in your `Chart.yml`

~~~yaml
dependencies:
  - name: keycloak
    version: "0.3.0-develop.4"
    repository: "oci://github.com/eniblock"
~~~

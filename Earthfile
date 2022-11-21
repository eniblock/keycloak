VERSION 0.6

reflex:
    FROM alpine
    RUN wget -O - https://github.com/cespare/reflex/releases/download/v0.3.1/reflex_linux_amd64.tar.gz | tar xvzC /usr/bin --strip-components=1 reflex_linux_amd64/reflex
    SAVE ARTIFACT /usr/bin/reflex

tar:
    FROM registry.access.redhat.com/ubi8
    SAVE ARTIFACT /usr/bin/tar

terraform:
    FROM hashicorp/terraform:1.3.2
    SAVE ARTIFACT /bin/terraform

build:
    FROM quay.io/keycloak/keycloak:18.0.2
    RUN /opt/keycloak/bin/kc.sh build \
        --health-enabled=true \
        --metrics-enabled=true \
        --db=postgres \
        --cache-stack=kubernetes \
        --http-relative-path=auth
    SAVE ARTIFACT /opt/keycloak/lib/quarkus/

docker:
    FROM quay.io/keycloak/keycloak:18.0.2
    USER root
    RUN curl -sSL https://github.com/powerman/dockerize/releases/download/v0.16.0/dockerize-linux-x86_64 > /usr/bin/dockerize \
        && chmod a+x /usr/bin/dockerize
    COPY +reflex/reflex /usr/bin/
    COPY +tar/tar /usr/bin/
    USER keycloak
    WORKDIR /opt/keycloak
    RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
    COPY +terraform/terraform /usr/bin/
    COPY --chown=keycloak configurator/*.tf /tf/
    RUN cd /tf \
        && terraform init --backend=false
    COPY --chown=keycloak configurator/*.sh /tf/
    COPY --chown=keycloak theme /opt/keycloak/themes/extra/
    COPY +build/quarkus/ /opt/keycloak/lib/quarkus/
    ARG tag=latest
    ARG ref=eniblock/keycloak:${tag}
    SAVE IMAGE --push ${ref}

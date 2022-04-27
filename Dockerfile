FROM alpine as reflex-downloader
RUN wget -O - https://github.com/cespare/reflex/releases/download/v0.3.1/reflex_linux_amd64.tar.gz | tar xvzC /usr/bin --strip-components=1 reflex_linux_amd64/reflex

FROM quay.io/keycloak/keycloak:18.0.0 as builder
RUN /opt/keycloak/bin/kc.sh build \
  --metrics-enabled=true \
  --db=postgres \
  --cache-stack=kubernetes \
  --http-relative-path=auth

FROM quay.io/keycloak/keycloak:18.0.0
USER root
RUN curl -sSL https://github.com/powerman/dockerize/releases/download/v0.16.0/dockerize-linux-x86_64 > /usr/bin/dockerize \
  && chmod a+x /usr/bin/dockerize
COPY --from=reflex-downloader /usr/bin/reflex /usr/bin/
COPY --from=registry.access.redhat.com/ubi8 /usr/bin/tar /usr/bin/
USER keycloak
WORKDIR /opt/keycloak
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
COPY --from=hashicorp/terraform:1.1.7 /bin/terraform /usr/bin/
COPY --chown=keycloak configurator/*.tf /tf/
RUN cd /tf \
  && terraform init --backend=false
COPY --chown=keycloak configurator/*.sh /tf/
COPY --chown=keycloak theme /opt/keycloak/themes/extra/
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/

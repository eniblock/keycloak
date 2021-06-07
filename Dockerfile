#
# Build keycloak extensions
#
FROM maven:3.6.3-jdk-11-slim AS KeycloakExtension
COPY extensions/src /home/app/src
COPY extensions/pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.skip=true

FROM bitnami/keycloak:12.0.4
USER root
RUN mkdir -p /scripts
COPY scripts /scripts
RUN curl -sL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz | tar xvzC /usr/bin
USER 1001
COPY certs/ /etc/x509/https/
COPY realm-config /realm-config
COPY standalone/standalone-ha.xml /opt/bitnami/keycloak/standalone/configuration/standalone-ha.xml
COPY --from=KeycloakExtension /home/app/src/kc-extension-ear/target/kc-extension-ear.ear /opt/bitnami/keycloak/standalone/deployments/

# the SMTP configuration variables
# SMTP_AUTH, SMTP_STARTTLS and SMTP_SSL are boolean that should be either true, false or an empty string
ENV SMTP_FROM=noreply@theblockchainxdev.com \
  SMTP_HOST=maildev \
  SMTP_AUTH= \
  SMTP_STARTTLS= \
  SMTP_SSL= \
  SMTP_USER= \
  SMTP_PASSWORD=

ENV REALM=main

CMD ["/scripts/bootstrap.sh", \
     "/opt/bitnami/scripts/keycloak/run.sh"]

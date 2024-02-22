FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz

WORKDIR /opt/keycloak

# for demonstration purposes only, please make sure to use proper certificates in production instead

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME=keycloak-duduso.zeabur.app
ENV KC_HTTPS_PROTOCOLS=TLSv1.3,TLSv1.2
ENV KC_HTTP_PORT=8080
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HTTP_ENABLED=true
#ENV KC_PROXY=edge
#ENV KC_FEATURES=token-exchange,admin-fine-grained-authz
#ENV PROXY_ADDRESS_FORWARDING=true
#ENV KC_HOSTNAME_STRICT_BACKCHANNEL=true

EXPOSE 8080
EXPOSE 8081
EXPOSE 8443

CMD ["start-dev"]

FROM quay.io/keycloak/keycloak:latest

# Make the realm configuration available for import
# COPY realm-export.json /opt/keycloak_import/

# Import the realm and user
# RUN /opt/keycloak/bin/kc.sh import --file /opt/keycloak_import/realm-export.json

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# The Keycloak server is configured to listen on port 8081
EXPOSE 8080
EXPOSE 8081
EXPOSE 8443

# Import the realm on start-up
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# FROM quay.io/keycloak/keycloak:20.0.3

# Make the realm configuration available for import
# COPY realm-export.json /opt/keycloak_import/

# Import the realm and user
# RUN /opt/keycloak/bin/kc.sh import --file /opt/keycloak_import/realm-export.json

# The Keycloak server is configured to listen on port 8080
# EXPOSE 8080
# EXPOSE 8443

# Import the realm on start-up
CMD ["docker", "run", "-p", "8080:8080", "-e", "KEYCLOAK_ADMIN=admin", "-e", "KEYCLOAK_ADMIN_PASSWORD=admin", "quay.io/keycloak/keycloak:23.0.6", "start-dev"]

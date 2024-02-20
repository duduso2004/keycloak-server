FROM quay.io/keycloak/keycloak:20.0.3

# Make the realm configuration available for import
COPY realm-export.json /opt/keycloak_import/

# Import the realm and user
RUN /opt/keycloak/bin/kc.sh import --file /opt/keycloak_import/realm-export.json

# The Keycloak server is configured to listen on port 8080
EXPOSE 8080
EXPOSE 8443

# Import the realm on start-up
CMD ["start-dev"]
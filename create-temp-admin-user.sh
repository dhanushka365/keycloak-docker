#!/bin/sh

# Sleep for a few seconds to allow Keycloak to start
sleep 10

# Run commands using kcadm.sh to create temporary admin user
/opt/jboss/keycloak/bin/kcadm.sh create users -r master -s username=temporary-admin -s enabled=true -s 'credentials=[{"type":"password", "value":"temporary-admin"}]'
/opt/jboss/keycloak/bin/kcadm.sh add-roles -r master --u temporary-admin --rolename=admin
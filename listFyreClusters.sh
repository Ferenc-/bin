#!/usr/bin/env bash

# USERNAMES ARE WITHOUT AN '@' !
USERNAME=$(yq ".username" ~/.fyre.yaml)
API_KEY=$(yq ".apikey" ~/.fyre.yaml)
CLUSTER_NAMES=$(curl -s -X GET -k -u "${USERNAME}:${API_KEY}" 'https://ocpapi.svl.ibm.com/v1/clusters/' | jq -r '.clusters.[].name')
for cn in ${CLUSTER_NAMES}; do
  echo -e "Cluster: ${cn}\n"
  curl -s -X GET -k -u "${USERNAME}:${API_KEY}" "https://ocpapi.svl.ibm.com/v1/clusters/${cn}/include_vms" \
    | jq -r '.cluster.vms.[] | .fqdn, .state, .cpu, .memory, .compliance' \
    | xargs -n 5 printf "  VM: %s\n  State: %s\n  CPU: %s\n  RAM: %s\n  Compliance: %s\n\n"
done

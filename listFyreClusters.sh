#!/usr/bin/env bash

# USERNAMES ARE WITHOUT AN '@' !
USERNAME=$(yq ".username" ~/.fyre.yaml)
API_KEY=$(yq ".apikey" ~/.fyre.yaml)
curl -s -X GET -k -u "${USERNAME}:${API_KEY}" 'https://ocpapi.svl.ibm.com/v1/clusters/' | jq

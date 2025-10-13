#!/usr/bin/env bash

# USERNAMES ARE WITHOUT AN '@' !
USERNAME=$(yq ".username" ~/.fyre.yaml)
API_KEY=$(yq ".apikey" ~/.fyre.yaml)
curl -X GET -k -u "${USERNAME}:${API_KEY}" 'https://api.fyre.ibm.com/rest/v1/?operation=query&request=showclusters' | jq 

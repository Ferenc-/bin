#!/usr/bin/env bash

# SOURCE this! With `source =loginAzureAKS.sh`
az login --use-device-code
az account set --subscription b564ebc3-ccf7-4476-848c-f8e8db966889
az aks get-credentials --resource-group team-k8s-east-us \
                       --name antonio-cluster-azure \
                       --overwrite-existing \
                       --file "${HOME}/.azure/team-k8s-east-us-antonio-cluster-azure-kubeconfig.yaml"

export KUBECONFIG="${HOME}/.azure/team-k8s-east-us-antonio-cluster-azure-kubeconfig.yaml"

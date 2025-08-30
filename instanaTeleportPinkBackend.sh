#!/usr/bin/env bash

tsh login --proxy=instana.club:443 --auth=w3id_identity --browser=none
tsh apps login --aws-role TeleportEngineerAccess aws-dev-infra
export KUBECONFIG="${HOME}/github.ibm.com/instana/backend/dev/scripts/instana_eks_test_cluster_config"

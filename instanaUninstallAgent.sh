#!/usr/bin/env bash
#https://www.ibm.com/docs/en/instana-observability/1.0.304?topic=kubernetes-uninstalling-agent#uninstalling-agents-installed-by-using-the-helm-chart

NAMESPACE=instana-agent
# delete agent custom resource, the operator will remove the agent artifacts it is owning
kubectl delete agents.instana.io instana-agent -n ${NAMESPACE} --wait
# uninstall helm chart which removes the operator and RBAC artifacts
helm uninstall instana-agent -n ${NAMESPACE}
# manually uninstall the custom resource definition which is not uninstalled by helm
kubectl delete crd agents.instana.io
# remove the entire namespace
kubectl delete namespace ${NAMESPACE}

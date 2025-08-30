NAMESPACE=instana-agent
#https://www.ibm.com/docs/en/instana-observability/1.0.304?topic=kubernetes-uninstalling-agent#uninstalling-agents-installed-by-using-the-helm-chart

# remove the finalizer
kubectl patch agents.instana.io instana-agent -p '{"metadata":{"finalizers":null}}' --type=merge -n ${NAMESPACE}
# remove the cluster-wide objects
kubectl delete crd/agents.instana.io clusterrole/leader-election-role clusterrole/instana-agent-clusterrole clusterrolebinding/leader-election-rolebinding clusterrolebinding/instana-agent-clusterrolebinding
# remove helm chart,if still present
helm uninstall instana-agent -n ${NAMESPACE} || true
# delete the entire namespace
kubectl delete ns ${NAMESPACE} --wait || true

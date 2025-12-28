#!/usr/bin/env bash

PATTERN="${1:-app=k8sensor@}"

for po in $(kubectl get -n instana-agent po -l app=k8sensor -o name | cut -f2 -d '/'); do kubectl logs -n instana-agent "${po}" | grep -i "${PATTERN}" ; done

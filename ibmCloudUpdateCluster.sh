#!/usr/bin/env bash

set -euo pipefail

# https://cloud.ibm.com/docs/containers?topic=containers-update&interface=ui#vpc_worker_node
ibmcloud ks cluster addon ls --cluster eng-k8s-test 
ibmcloud ks addon-versions
ibmcloud ks cluster addon update vpc-block-csi-driver --version 5.2 --cluster eng-k8s-test
# https://cloud.ibm.com/docs/containers?topic=containers-update&interface=ui#vpc_worker_node
ibmcloud ks cluster ls
ibmcloud ks cluster master update --version 1.33 --cluster eng-k8s-test

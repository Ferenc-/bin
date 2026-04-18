#!/usr/bin/env bash
ibmcloud login -a 'cloud.ibm.com' -r 'us-south' -g 'eng-k8s' -c '837c2690905f46f98ab474a8297bcaa3' --sso
sleep 10
ibmcloud ks cluster config --cluster 'd2f00ddd0d08dc9fh5og'

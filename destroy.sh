#!/bin/bash

CURRENT_WORKDIR=$(pwd)
HELM_REPO="${CURRENT_WORKDIR}/helm_chart"
ARGOCD=${HELM_REPO}/argo-cd-6.7.15
CONFIGMAP=${ARGOCD}/configmap 
EXTENRAL_DNS=${HELM_REPO}/external-dns-7.2.0


helm uninstall external-dns -n external-dns-ns
helm uninstall argocd -n argocd

sleep 10s
cd terraform-modules
terraform destroy -auto-approve
#!/bin/bash
CURRENT_WORKDIR=$(pwd) # /Users/whoopi/simplifywoopii
ARGODIR=${CURRENT_WORKDIR}/helm_chart/argo-cd-6.7.15/configmap


kubectl delete -f ${ARGODIR}/argocd-cm.yaml
kubectl delete -f ${ARGODIR}/argocd-rbac-cm.yaml

kubectl create -f ${ARGODIR}/argocd-cm.yaml --save-config
kubectl create -f ${ARGODIR}/argocd-rbac-cm.yaml --save-config

kubectl rollout restart deployment argocd-server -n argocd
kubectl rollout restart deployment argocd-applicationset-controller -n argocd
kubectl rollout restart deployment argocd-dex-server -n argocd
kubectl rollout restart deployment argocd-notifications-controller -n argocd
kubectl rollout restart deployment argocd-redis -n argocd
kubectl rollout restart deployment argocd-repo-server -n argocd
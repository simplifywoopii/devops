#!/bin/bash

kubectl delete -f argocd-cm.yaml
kubectl delete -f argocd-rbac-cm.yaml

kubectl create -f argocd-cm.yaml --save-config
kubectl create -f argocd-rbac-cm.yaml --save-config

kubectl rollout restart deployment argocd-server -n argocd
kubectl rollout restart deployment argocd-applicationset-controller -n argocd
kubectl rollout restart deployment argocd-dex-server -n argocd
kubectl rollout restart deployment argocd-notifications-controller -n argocd
kubectl rollout restart deployment argocd-redis -n argocd
kubectl rollout restart deployment argocd-repo-server -n argocd
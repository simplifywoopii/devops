#!/bin/bash

if [[ $1 == "all" ]]; then
    docker compose build --no-cache
    docker compose run --rm gke
    docker compose run --rm gke sh -c "terraform apply -auto-approve"
fi



CURRENT_WORKDIR=$(pwd)
ARGOCD_CONFIGMAP_DIR="${CURRENT_WORKDIR}/argocd_configmap"

# gke authenticate
sleep 1s
gcloud container clusters get-credentials ${GOOGLE_GKE_CLUSTER_NAME} --region ${GOOGLE_REGION} --project ${GOOGLE_PROJECT_ID}
sleep 3s


# helm 여부 확인
if [[ $1 == "argo" ]] || [[ $1 == "all" ]]; then
    exists=$(helm ls -n ${GOOGLE_HELM_ARGOCD_NAMESPACE} | awk '{if ($1 == "argocd")  print $1}')
    if [[ $exists == ${GOOGLE_HELM_ARGOCD_NAME} ]];then
        # helm chart가 존재
        kubectl delete -f ${ARGOCD_CONFIGMAP_DIR}/argocd-cm.yaml
        kubectl delete -f ${ARGOCD_CONFIGMAP_DIR}/argocd-rbac-cm.yaml

        kubectl create -f ${ARGOCD_CONFIGMAP_DIR}/argocd-cm.yaml --save-config
        kubectl create -f ${ARGOCD_CONFIGMAP_DIR}/argocd-rbac-cm.yaml --save-config

        echo "\n\n[INFO] Argocd rollout restart\n\n"

        kubectl rollout restart deployment argocd-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
        kubectl rollout restart deployment argocd-applicationset-controller -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
        kubectl rollout restart deployment argocd-dex-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
        kubectl rollout restart deployment argocd-notifications-controller -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
        kubectl rollout restart deployment argocd-redis -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
        kubectl rollout restart deployment argocd-repo-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
    fi
fi

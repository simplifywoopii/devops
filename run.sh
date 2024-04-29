#!/bin/bash

CURRENT_WORKDIR=$(pwd)
HELM_REPO="${CURRENT_WORKDIR}/helm_chart"
ARGOCD=${HELM_REPO}/argo-cd-6.7.15
CONFIGMAP=${ARGOCD}/configmap 
EXTENRAL_DNS=${HELM_REPO}/external-dns-7.2.0


terraform run
cd terraform-modules
terraform init -backend-config backend.conf
terraform apply -auto-approve
cd ..


sleep 5s
gcloud container clusters get-credentials simplifywoopii-devops-gke --region us-central1 --project devops-421112

sleep 5s
# helm 여부 확인
exists=$(helm ls -n external-dns-ns | awk 'BEGIN {count=0} { if ($1 == "external-dns") count+=1} END  {print count}')
if [[ $exists == '1' ]];then
    helm upgrade external-dns -f "${EXTENRAL_DNS}/ci/override_values.yaml" -n external-dns-ns ${EXTENRAL_DNS}
else
    helm install external-dns -f "${EXTENRAL_DNS}/ci/override_values.yaml" -n external-dns-ns --create-namespace ${EXTENRAL_DNS}
fi



sleep 5s
exists=$(helm ls -n argocd | awk 'BEGIN {count=0} { if ($1 == "argocd") count+=1} END  {print count}')
if [[ $exists == '1' ]];then
    helm upgrade argocd -f "${ARGOCD}/ci/override_values.yaml" -n argocd ${ARGOCD}
else
    helm install argocd -f "${ARGOCD}/ci/override_values.yaml" -n argocd --create-namespace ${ARGOCD}
fi

sleep 10s
bash ${CONFIGMAP}/run.sh


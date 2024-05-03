envsubst < pod2.yaml | kubectl apply -f -

envsubst < argocd-config/argocd-cm.yaml| kubectl apply -f -
envsubst < argocd-config/argocd-rbac-cm.yaml| kubectl apply -f -


kubectl rollout restart deployment argocd-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
kubectl rollout restart deployment argocd-applicationset-controller -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
kubectl rollout restart deployment argocd-dex-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
kubectl rollout restart deployment argocd-notifications-controller -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
kubectl rollout restart deployment argocd-redis -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
kubectl rollout restart deployment argocd-repo-server -n ${GOOGLE_HELM_ARGOCD_NAMESPACE}
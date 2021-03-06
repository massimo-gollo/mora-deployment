## install && configure prometheus operatator
set -eux
BASEPATH=$(pwd)
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update
##TODO moved in helm chart vp-cloud
#kubectl create ns monitoring
#expose grafana
helm install kps-"$1" prometheus-community/kube-prometheus-stack -n monitoring -f $BASEPATH/custom-kps/values.kps.yaml --set grafana.service.type=NodePort
kubectl patch service kps-"$1"-grafana -n monitoring --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":30002}]'
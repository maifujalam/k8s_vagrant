Install Metric Server:-

1. helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
2.  h search repo metric
3. h pull metrics-server/metrics-server  --version 3.11.0 --untar
4. Update values.yaml
5. helm install metrics-server metrics-server -n kube-system --values metrics-server/values.yaml
6. helm upgrade metrics-server /vagrant/manifests/metrics-server -n kube-system --values /vagrant/manifests/metrics-server/values.yaml
7. helm -n kube-system uninstall metrics-server

Cert-manager:-
1. helm repo add jetstack https://charts.jetstack.io
2. helm repo update
3. helm search repo cert-manager
4. helm pull jetstack/cert-manager --version=1.12.3 --untar
5. kubectl create ns cert-manager
6. helm install cert-manager cert-manager -n cert-manager --values cert-manager/values.yaml

nginx-ingress-controller
1. helm repo add bitnami https://charts.bitnami.com/bitnami
2. helm repo update
3. helm search repo nginx-ingress-controller
4. helm pull bitnami/nginx-ingress-controller --version=9.8.0 --untar
5. kubectl create ns nginx-ingress-controller
6. helm install nginx-ingress-controller nginx-ingress-controller -n nginx-ingress-controller -f nginx-ingress-controller/values.yaml

Dashboard:
1. helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
2. helm repo update
3. helm search repo dashboard 
4. helm pull kubernetes-dashboard/kubernetes-dashboard --version=7.0.3 --untar
5. h install k8s-dashboard kubernetes-dashboard -n kubernetes-dashboard --values kubernetes-dashboard/values.yaml
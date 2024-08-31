Install Metric Server:-

1. helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
2. helm repo update
3. helm search repo metrics-server
4. helm pull metrics-server/metrics-server --version 3.12.1 --untar
5. Update values.yaml
6. helm install metrics-server metrics-server -n kube-system --values metrics-server/values.yaml
7. helm upgrade metrics-server /vagrant/manifests/metrics-server -n kube-system --values /vagrant/manifests/metrics-server/values1.yaml
8. helm -n kube-system uninstall metrics-server

kube-vip:- 
1. helm repo add kube-vip https://kube-vip.github.io/helm-charts 
2. helm repo update
3. helm search repo vip
4. helm pull kube-vip/kube-vip --version 0.4.4 --untar
5. helm pull kube-vip/kube-vip-cloud-provider --version 0.2.2 --untar
6. Update both values.yaml
7. helm install kube-vip --create-namespace --namespace kube-vip /vagrant/manifests/kube-vip/kube-vip
8. helm install kube-vip-cloud-provider --create-namespace --namespace kube-vip /vagrant/manifests/kube-vip/kube-vip-cloud-provider/values1.yaml
9. helm uninstall -n kube-vip kube-vip
10. helm uninstall -n kube-vip kube-vip-cloud-provider

Cert-manager:-
1. helm repo add jetstack https://charts.jetstack.io
2. helm repo update
3. helm search repo cert-manager
4. helm pull jetstack/cert-manager --version=1.15.3 --untar
5. kubectl create ns cert-manager
6. helm install cert-manager cert-manager -n cert-manager
7. helm -n cert-manager upgrade cert-manager
8. helm -n cert-manager uninstall cert-manager

trust-manager:-
1. helm repo add jetstack https://charts.jetstack.io
2. helm repo update
3. helm search repo trust-manager
4. helm pull jetstack/trust-manager --version=1.12.3 --untar

nginx-ingress-controller
1. helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
2. helm repo update
3. helm search repo nginx
4. helm pull ingress-nginx/ingress-nginx --version=4.11.2 --untar
5. kubectl create ns ingress-nginx
6. helm install ingress-nginx ingress-nginx -n ingress-nginx -f ingress-nginx/values1.yaml
7. helm uninstall ingress-nginx -n ingress-nginx
8. External load balancer IP: 192.168.56.5

kubernetes-dashboard:
1. helm repo add kubernetes-dashboard  https://kubernetes.github.io/dashboard
2. helm repo update
3. helm search repo dashboard 
4. helm pull k8s-dashboard/kubernetes-dashboard --version=7.5.0 --untar
5. kubectl create ns kubernetes-dashboard
6. helm -n kubernetes-dashboard install kubernetes-dashboard/vagrant/manifests/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
    helm install kubernetes-dashboard  kubernetes-dashboard -n kubernetes-dashboard --create-namespace
7. helm -n kubernetes-dashboard upgrade k8s-dashboard kubernetes-dashboard
8. helm uninstall kubernetes-dashboard -n kubernetes-dashboard && kubectl delete ns kubernetes-dashboard

kube-prometheous-stack
1. helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
2. helm repo update
3. helm search repo kube-prometheus-stack
4. helm pull prometheus-community/kube-prometheus-stack --version=61.8.0 --untar
5. helm -n monitoring install kube-prometheus-stack kube-prometheus-stack --create-namespace
6. helm -n monitoring uninstall kube-prometheus-stack
7. helm -n monitoring upgrade kube-prometheus-stack kube-prometheus-stack 
8. Creds: admin/prom-operator [ k -n monitoring get secret kube-prometheus-stack-grafana --template='{{ index .data "admin-password" | base64decode}}' ]

prometheus[not required if using kube prometheous stack]:
1. helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
2. helm repo update
3. helm search repo prometheus
4. helm pull prometheus-community/prometheus --version=25.10.0 --untar
5. helm -n monitoring install prometheus prometheus --create-namespace
6. helm -n monitoring uninstall prometheus
7. helm -n monitoring upgrade prometheus prometheus --create-namespace


Grafana[not required if using kube prometheous stack]:-
1. helm repo add grafana https://grafana.github.io/helm-charts
2. helm repo update
3. helm search repo grafana
4. helm pull grafana/grafana --version=7.2.5 --untar
5. helm -n grafana install grafana grafana --create-namespace
6. helm -n grafana upgrade grafana grafana --create-namespace
7. helm -n grafana uninstall grafana
8. Default pass admin/admin

Docker Registry:-
1. helm repo add twuni https://helm.twun.io
2. helm repo update
3. helm search repo registry
4. helm pull twuni/docker-registry --version=2.2.2 --untar
5. helm -n image-registry install docker-registry docker-registry --create-namespace
6. helm -n image-registry upgrade docker-registry docker-registry --create-namespace
7. helm -n image-registry uninstall docker-registry
8. Creds: cluster-url: docker-registry:5000  curl -X GET https://docker-registry.master.com/v2/_catalog -k

Blackbox Exporter:-
1. helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
2. helm search repo blackbox
3. helm pull prometheus-community/prometheus-blackbox-exporter --version=9.0.0 --untar
4. helm -n blackbox-exporter install blackbox prometheus-blackbox-exporter --create-namespace
5. helm -n blackbox-exporter upgrade blackbox prometheus-blackbox-exporte
6. helm -n blackbox-exporter uninstall blackbox

Argocd:
1. helm repo add argo https://argoproj.github.io/argo-helm
2. helm repo update
3. helm search repo argo-cd
4. helm pull argo/argo-cd --version 7.4.3 --untar
5. helm -n argo-cd install argo-cd /vagrant/manifests/argo-cd --create-namespace --namespace argo-cd
6. helm -n argo-cd uninstall argo-cd && kubectl delete ns argo-cd --force
7. helm -n argo-cd upgrade argo-cd /vagrant/manifests/argo-cd

hello-kubernetes:-
1. helm install helloworld hello-kubernetes
2. helm upgrade helloworld hello-kubernetes
3. helm uninstall helloworld

hello-kubernetes-2:-
1. helm -n hello2 install hello2 hello-kubernetes --create-namespace

Helm Package:-
1. Build number is based on Char.yaml->version
2. Helm package: h package hello-kubernetes
3. 
Install Metric Server:-

1. helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
2.  h search repo metric
3. h pull metrics-server/metrics-server  --version 3.11.0 --untar
4. Update values.yaml
5. helm install metrics-server metrics-server -n kube-system --values metrics-server/values.yaml
6. helm upgrade metrics-server /vagrant/manifests/metrics-server -n kube-system --values /vagrant/manifests/metrics-server/values1.yaml
7. helm -n kube-system uninstall metrics-server

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
4. helm pull jetstack/cert-manager --version=1.12.3 --untar
5. kubectl create ns cert-manager
6. helm install cert-manager cert-manager -n cert-manager --values cert-manager/values1.yaml

trust-manager:-
1. helm repo add jetstack https://charts.jetstack.io
2. helm repo update
3. helm search repo trust-manager
4. helm pull jetstack/trust-manager --version=1.12.3 --untar

nginx-ingress-controller
1. helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
2. helm repo update
3. helm search repo nginx
4. helm pull ingress-nginx/ingress-nginx --version=4.7.1 --untar
5. kubectl create ns ingress-nginx
6. helm install ingress-nginx ingress-nginx -n ingress-nginx -f ingress-nginx/values1.yaml
7. helm uninstall ingress-nginx -n ingress-nginx
8. External load balancer IP: 192.168.56.5

kubernetes-dashboard:
1. helm repo add kubernetes-dashboard  https://kubernetes.github.io/dashboard
2. helm repo update
3. helm search repo dashboard 
4. helm pull kubernetes-dashboard/kubernetes-dashboard --version=7.0.0-alpha1 --untar
5. kubectl create ns kubernetes-dashboard
5. helm install kubernetes-dashboard  kubernetes-dashboard -n kubernetes-dashboard --values kubernetes-dashboard/values1.yaml
6. helm uninstall kubernetes-dashboard -n kubernetes-dashboard

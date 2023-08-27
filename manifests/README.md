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
1. helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
2. helm repo update
3. helm search repo nginx
4. helm pull ingress-nginx/ingress-nginx --version=4.7.1 --untar
5. kubectl create ns ingress-nginx
6. helm install ingress-nginx ingress-nginx -n ingress-nginx -f ingress-nginx/values.yaml
7. helm uninstall ingress-nginx -n ingress-nginx

kubernetes-dashboard:
1. helm repo add kubernetes-dashboard  https://kubernetes.github.io/dashboard
2. helm repo update
3. helm search repo dashboard 
4. helm pull kubernetes-dashboard/kubernetes-dashboard --version=7.0.0-alpha0 --untar
5. kubectl create ns kubernetes-dashboard
5. helm install kubernetes-dashboard  kubernetes-dashboard -n kubernetes-dashboard --values kubernetes-dashboard/values.yaml
6. helm uninstall kubernetes-dashboard -n kubernetes-dashboard
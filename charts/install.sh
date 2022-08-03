# Install ingress
helm upgrade --cleanup-on-fail --install ingress-nginx ./ingress-nginx -f ingress-nginx-config.yaml

# Install kubernetes-dashboard
helm upgrade --cleanup-on-fail --install kubernetes-dashboard ./kubernetes-dashboard -n kubernetes-dashboard --create-namespace
kubectl create -f kubernetes-dashboard-ingress.yaml
kubectl -n kubernetes-dashboard create token dashboard-admin --duration 0

# Install Jupyter
kubectl create -f ./jupyterhub.yaml
helm upgrade --cleanup-on-fail --install jupyterhub ./jupyterhub --namespace jupyter --create-namespace -f ./jupyterhub-config.yaml

# Install alluxio
helm upgrade --cleanup-on-fail --install alluxio ./alluxio --namespace spark -f ./alluxio-config.yaml
# Install ingress
helm upgrade --cleanup-on-fail --install ingress-nginx ./ingress-nginx -f ingress-nginx-config.yaml

# Install kubernetes-dashboard
helm upgrade --cleanup-on-fail --install kubernetes-dashboard ./kubernetes-dashboard -n kubernetes-dashboard --create-namespace
kubectl create -f dashboard.yaml
kubectl -n kubernetes-dashboard create token dashboard-admin --duration 0

# Install minio
helm upgrade --cleanup-on-fail --install minio ./minio --namespace storage --values ./minio-config.yaml

# Spark operator
helm upgrade --cleanup-on-fail --install spark-operator ./spark-operator --namespace compute --create-namespace --values ./spark-operator-config.yaml

# Install Jupyter
kubectl create -f ./jupyterhub.yaml
helm upgrade --cleanup-on-fail --install jupyterhub ./jupyterhub --namespace jupyter --create-namespace -f ./jupyterhub-config.yaml

# Install alluxio
helm upgrade --cleanup-on-fail --install alluxio ./alluxio --namespace spark -f ./alluxio-config.yaml
# Install alluxio
helm upgrade --cleanup-on-fail --install alluxio .\alluxio\ --namespace spark -f .\alluxio-config.yaml
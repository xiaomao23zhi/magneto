## Versions
| NAME                             | CHART                            | APP VERSION
| -------------------------------- | -------------------------------- | --------------------------------
| jupyterhub                       | jupyterhub-1.1.3                 | 1.4.2
| dask-gateway                     | dask-gateway-0.9.0               | 0.9.0
| spark-operator                   | spark-operator-1.1.11            | v1beta2-1.2.3-3.1.1
| spark-history-server             | spark-history-server-1.4.3       | 3.1.1
| livy-server                      | livy-2.0.1                       | v0.8.0-incubating-SNAPSHOT

## Install
```shell
$ helm upgrade --cleanup-on-fail --install spark-operator ./spark-operator --namespace spark --create-namespace --values spark-operator-config.yaml
$ helm upgrade --cleanup-on-fail --install spark-history-server ./spark-history-server --namespace spark --create-namespace --values spark-history-server-config.yaml
$ helm upgrade --cleanup-on-fail --install livy-server ./livy --namespace spark --create-namespace --values livy-config.yaml
```
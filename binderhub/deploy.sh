kubectl create namespace binderhub
helm install binderhub jupyterhub/binderhub --version=0.2.0-n217.h35366ea --namespace=binderhub -f secret.yaml -f config.yaml
helm upgrade binderhub jupyterhub/binderhub --version=0.2.0-n217.h35366ea -f secret.yaml -f config.yaml

helm upgrade binderhub jupyterhub/binderhub --version=0.2.0-n636.h8e3b5ac --namespace=binderhub -f binderhub/secret.yaml -f binderhub/config_basic.yaml --install --create-namespace
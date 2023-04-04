# Deploying to Kubernetes
## Local Deployment

The BIA-binder is fully deployed using helmsman which can be installed using your preferred package manager, e.g. on mac:

```
brew install helmsman
```

```Helmsman``` repackages ```helmsman``` yaml files into ```helm``` (the preferred Kubernetes package manager) commands.

Once installed the full environment can be deployed using

```
helmsman --apply -f helmsman.yaml -f helmsman-prod.yaml
```

This can be limited to only the dev environment say using 

```
helmsman --apply -f helmsman.yaml -f helmsman-prod.yaml --group dev
```

Helmsman is expecting that the context name of the cluster you are deploying to is called CPU. To deploy to a cluster called say GPU, and with the necessary GPU overrides for JupyterHub and Binderhub, you append the `helmsman-gpu.yaml` 

```
helmsman --apply -f helmsman.yaml -f helmsman-prod.yaml -f helmsman-gpu.yaml
``` 
`helmsman-token.yaml` is reserved for runners within the cluster deploying to the cluster as would be the case with GitLab, which is how the BIA-Binder is deployed.

The minikube variant of the deployment is also availiable using
```
helmsman --apply -f helmsman.yaml -f helmsman-minikube.yaml
```
The ``'helmsman-*'`` files can all be mixed and matched but the order of operations does matter. 



<!-- # Deploying and updating the IDR VAE

GitLab CI/CD, configured in [`.gitlab-ci.yml`](../.gitlab-ci.yml)

## Helm charts

Everything is deployed using Helm charts, managed with the Helmfile tool which is configured in [`helmfile.yaml`](../helmfile.yaml).


## Configuration

There are four JupyterHub deployments all use a common configuration in [`jupyterhub-config.yaml`](../jupyterhub-config.yaml) with additional configuration or overrides in separate files.

## Configure secret variables for the deployments

Since this repository is intentionally public (including the CI/CD logs) secret variables are set in the Gitlab CI/CD settings.
Take care to ensure these variables are always protected, and are never displayed in logs.

Setup Secret variables referenced in [`.gitlab-ci.yml`](../.gitlab-ci.yml):


- `SECRET_ELIXIR_CLIENTID` \
- `SECRET_ELIXIR_CLIENTSECRET` \
- `SECRET_GITHUB_CLIENTID` \
- `SECRET_GITHUB_CLIENTSECRET` \
- `SECRET_GRAFANA_GITHUB_CLIENTID` \
- `SECRET_GRAFANA_GITHUB_SECRET` \
- `SECRET_HUB_PASSWORD` \
- `SECRET_JUPYTERHUB_PROXY_TOKEN` \
- `SECRET_PROMETHEUS_AUTH_HTPASSWD`


### Deployment Docker image

GitLab executes the deployment using a custom Docker image [`imagedata/kube-helm-docker:0.1.0`](https://hub.docker.com/r/imagedata/kube-helm-docker/).
 -->

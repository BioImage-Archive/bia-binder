# Deploying and updating the IDR VAE

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


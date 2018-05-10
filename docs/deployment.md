# Deploying and updating the IDR VAE

All deployment on the IDR VAE is done from the `master` branch of this repository using GitLab CI/CD, configured in [`.gitlab-ci.yml`](../.gitlab-ci.yml)


## Helm charts

Everything is deployed using Helm charts, managed with the Helmfile tool which is configured in [`helmfile.yaml`](../helmfile.yaml).

Most charts are released upstream:
  - JupyterHub
  - Grafana
  - Prometheus

A few are custom written for this project.
These are in the [`charts`](../charts/) directory:
  - [`charts/idr-analysis-website`](../charts/idr-analysis-website/) is the static website content
  - [`charts/jupyterhub-shared-scratch`](../charts/jupyterhub-shared-scratch) creates the shared scratch space for the VAE (user scratch spaces are automatically created by JupyterHub)


## Configuration

There are four JupyterHub deployments.
All use the common configuration in [`jupyterhub-config.yaml`](../jupyterhub-config.yaml) with additional configuration or overrides in separate files.

### 1. JupyterHub `staging`
This is always deployed as soon as the `master` branch is updated, and is fully configured by [`jupyterhub-config.yaml`](../jupyterhub-config.yaml).

### 2. JupyterHub `public`
This configuration is identical to `staging` apart from the URL [`jupyterhub-public.yaml`](../jupyterhub-public.yaml).

### 3. JupyterHub `vae`
This is the most important deployment that requires GitHub login, but offers extra benefits including more resources and persistent storage [`jupyterhub-vae.yaml`](../jupyterhub-vae.yaml).

### 4. JupyterHub `vae-aai`
This is identical to the public deployment, and is a demonstration of Elixir AAI login.
It does not offer the extra benefits of `vae` [`jupyterhub-vae-aai.yaml`](../jupyterhub-vae-aai.yaml).

### Prometheus
Prometheus is installed from the upstream helm chart.
It has a 10GB volume, and metrics are retained for 21 days [`prometheus.yaml`](../prometheus.yaml).
There is no external access.

### Grafana
Grafana installed from the upstream helm chart.
It is currently protected by GitHub OAuth, though this may change in future after a review of the accessible information.
Two dashboards are automatically installed [`grafana.yaml`](../grafana.yaml).


## Configure secret variables for the deployments
Since this repository is intentionally public (including the CI/CD logs) secret variables are set in the Gitlab CI/CD settings.
Take care to ensure these variables are always protected, and are never displayed in logs.

Setup Secret variables referenced in [`.gitlab-ci.yml`](../.gitlab-ci.yml):
- `SECRET_JUPYTERHUB_PROXY_TOKEN`
- `SECRET_IDR_PASSWORD`
- `SECRET_GITHUB_CLIENTID` (production-vae only)
- `SECRET_GITHUB_CLIENTSECRET` (production-vae only)
- `SECRET_AAI_CLIENTID`: (production-vae-aai only)
- `SECRET_AAI_CLIENTSECRET`: (production-vae-aai only)
- `SECRET_GRAFANA_GITHUB_CLIENTID`: (production-monitoring only)
- `SECRET_GRAFANA_GITHUB_SECRET`: (production-monitoring only)

![GitLab secret variables](gitlab-secret-variables.png)

In future we may move to manually creating Kubernetes secrets in advance if supported by the corresponding Helm charts, for example https://github.com/kubernetes/charts/pull/5435


## Deployment process
Make any modifications to the Helm chart configuration.
Push this to GitHub `master`, either directly or by merging a pull request.
This will automatically trigger the `staging` deployment.

All other stages are gated by a manual step.
Go to the GitLab Pipelines view, e.g. https://gitlab.com/openmicroscopy/mirrors/k8s-analysis-deploy/pipelines.
In the listed stages go to `Approval` and click through.
Once this is done the remaining deployment jobs should be automatically created and run.

Note we do not distinguish between updating a single or multiple applications.
Instead we always deploy everything and rely on the idempotency provided by Kubernetes and Helm to only modify things when necessary.

In future we may move to a full staging environment including automated tests, and no manual approval step.

### Deployment Docker image
GitLab executes the deployment using a custom Docker image [`imagedata/kube-helm-docker:0.1.0`](https://hub.docker.com/r/imagedata/kube-helm-docker/).
At present this includes a forked version of Helmfile to prevent secrets being printed out when the default verbosity level is used.


### Known issues

If you see an error along the lines of
```
Error: UPGRADE FAILED: render error in
"jupyterhub/templates/proxy/deployment.yaml": template:
jupyterhub/templates/proxy/deployment.yaml:17:32: executing
"jupyterhub/templates/proxy/deployment.yaml" at <include (print $.Tem...>: error
calling include: template: jupyterhub/templates/hub/secret.yaml:7:19: executing
"jupyterhub/templates/hub/secret.yaml" at <required "Proxy toke...>: error
calling required: Proxy token must be a 32 byte random string generated with
`openssl rand -hex 32`! err: exit status 1 ERROR: Job failed: error executing
remote command: command terminated with non-zero exit code: Error executing in
Docker Container: 1
```
This may be a race condition.
Retry the job.

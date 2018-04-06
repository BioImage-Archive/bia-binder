# Continuous deployment for the IDR Kubernetes analysis platform

Setup GitLab continuous deployment for IDR K8s analysis.


## Create a `CI/CD for external repo` project on GitLab

https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/github_integration.html

All configuration and code changes should be done in the GitHub repository.
The GitLab repository is purely a mirror for integration with CI/CD.


## Create a namespace, role, account and additional token for the Gitlab runner

https://kubernetes.io/docs/admin/service-accounts-admin/

    kubectl apply -f ./k8s-clusterrole/

This will give the GitLab runner almost full administrative access to the cluster.

[`k8s-role`](./k8s-role/) contains a role to restrict access to just the `gitlab` namespace, but this will not work for deployment in this repository since they require multiple namespaces.


## Install GitLab runner

https://docs.gitlab.com/ee/install/kubernetes/gitlab_runner_chart.html#installing-gitlab-runner-using-the-helm-chart

Go to the `Runners settings` tab under https://gitlab.com/USERNAME/REPOSITORY/settings/ci_cd.
Get the Runner registration token from and set `runnerRegistrationToken` in gitlab-runner/helm-config.yaml to this value.
The gitlab runner requires additional configuration that is not supported by the chart so at present you must [checkout a fork/PR](https://gitlab.com/charts/charts.gitlab.io/merge_requests/120):

    git clone --branch runner-environment https://gitlab.com/manics/charts.gitlab.io.git
    helm install --namespace gitlab --name gitlab-runner charts.gitlab.io/charts/gitlab-runner/ -f gitlab-runner/helm-config.yaml

If the upstream chart is updated and released installation will be simpler:

    helm repo add gitlab https://charts.gitlab.io
    helm install --namespace gitlab --name gitlab-runner gitlab/gitlab-runner -f gitlab-runner/helm-config.yaml

Ensure you `Disable shared Runners`.
This repo is used for deployments so shared GitLab runners cannot be used.

**WARNING**: GitLab allows you to share runners across multiple projects.
Ensure it is disabled since this runner has administrative permissions to manage the deployments so only fully trusted scripts should be run.


## Configure secret variables for the deployment

Setup Secret variables referenced in [`.gitlab-ci.yml`](.gitlab-ci.yml):
- `SECRET_JUPYTERHUB_PROXY_TOKEN`
- `SECRET_IDR_PASSWORD`
- `SECRET_GITHUB_CLIENTID` (production-vae only)
- `SECRET_GITHUB_CLIENTSECRET` (production-vae only)

![GitLab secret variables](docs/gitlab-secret-variables.png)

## Additional notes

You can add details of the Kubernetes cluster to Gitlab to get additional integration: https://gitlab.com/help/user/project/clusters/index#adding-an-existing-kubernetes-cluster.
However this didn't work for me.

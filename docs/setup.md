# Setup

Instructions for configuring GitLab continuous deployment with this repository.


## Create a `CI/CD for external repo` project on GitLab

https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/github_integration.html

All configuration and code changes should be done in the GitHub repository.
The GitLab repository is purely a mirror for integration with CI/CD.

Alternatively if you do not require GitHub just clone this repository directly to GitLab.


## Create a namespace, role, account and additional token for the Gitlab runner

https://kubernetes.io/docs/admin/service-accounts-admin/

    kubectl apply -f ./k8s-clusterrole/

This will give the GitLab runner almost full administrative access to the cluster.


## Install GitLab runner

https://docs.gitlab.com/ee/install/kubernetes/gitlab_runner_chart.html#installing-gitlab-runner-using-the-helm-chart

Go to the `Runners settings` tab under https://gitlab.com/USERNAME/REPOSITORY/settings/ci_cd.
Get the Runner registration token from and set `runnerRegistrationToken` in [`gitlab-runner/helm-config.yaml`](../gitlab-runner/helm-config.yaml) to this value.

Install the chart (`0.9.1` is the current stable release on 2019-10-07):

    helm repo add gitlab https://charts.gitlab.io
    helm repo update
    helm upgrade --install --namespace gitlab gitlab-runner gitlab/gitlab-runner --version 0.9.1 -f gitlab-runner/helm-config.yaml

This repo is used for deployments so shared GitLab runners cannot be used, irrespective of whether they are public or inside the group.
Ensure you `Disable shared Runners`.

**WARNING**: GitLab allows you to share runners across multiple projects.
Ensure it is disabled since this runner has administrative permissions to manage the deployments so only fully trusted scripts should be run.



## Additional notes

If you are using a mirrored repository prevent changes to the GitLab repository by protecting the `master` branch under https://gitlab.com/USERNAME/REPOSITORY/settings/ci_cd and setting `No one` allowed to merge or push.

You can add details of the Kubernetes cluster to Gitlab to get additional integration: https://gitlab.com/help/user/project/clusters/index#adding-an-existing-kubernetes-cluster.
However this didn't work for me.

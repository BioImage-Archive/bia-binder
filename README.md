<!-- # Bio-Image Archive Kubernetes analysis platform -->

<!-- - [`setup.md`](docs/setup.md) If you are setting this up from scratch follow these instructions to setup GitLab CI/CD.
- [`deployment.md`](docs/deployment.md) If you wish to change the deployment read this. -->


## Quick start

Install minikube and helmfile

    https://kubernetes.io/docs/tasks/tools/install-minikube/
    https://github.com/roboll/helmfile#installation

Add the secrets to your local environment

    source secrets.env
<!-- 
Create a namespace, role, account and additional token for the Gitlab runner

https://kubernetes.io/docs/admin/service-accounts-admin/

    kubectl apply -f ./k8s-clusterrole/

This will give the GitLab runner almost full administrative access to the cluster.

    bash gitlab-ci/install-helm.sh
    helmfile -e minikube sync

For production

    helmfile -e default sync -->

## TODO

- Continuous integration
- Elixir login portal

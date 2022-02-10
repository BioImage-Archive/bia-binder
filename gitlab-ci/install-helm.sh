#!/bin/sh
# Install and secure access to Helm
set -eux

echo '{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"name": "tiller"}}' | kubectl apply -n kube-system -f -
echo '{"apiVersion": "rbac.authorization.k8s.io/v1","kind": "ClusterRoleBinding","metadata":{"name":"tiller"},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind": "ClusterRole","name": "cluster-admin"},"subjects":[{"kind": "ServiceAccount","name": "tiller","namespace": "kube-system"}]}' | kubectl apply -n kube-system -f -

helm init --upgrade --service-account tiller

# https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/8209ea252a1ec2cdb90640ea2a2735467b4aadbc/doc/source/security.md#secure-access-to-helm
kubectl --namespace=kube-system patch deployment tiller-deploy --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'

echo "waiting for tiller"
kubectl --namespace=kube-system rollout status --watch deployment/tiller-deploy

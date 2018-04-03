#!/bin/sh
set -eu

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm repo list
helm list

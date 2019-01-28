#!/bin/bash

# A helper script to start a Docker environment with kubectl helm helmfile
# preinstalled and configured for connecting to minikube

# Install all
#     helmfile -e minikube sync
# Install a subset of charts
#     helmfile -e minikube -l application=public sync
#     helmfile -e minikube -l application=vae -l application=monitoring sync

if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$PWD" ]; then
    echo Must be run from script parent directory
    exit 2
fi

exec docker run -it --rm \
    -v "$HOME/.kube:/home/kube/.kube:ro" \
    -v "$PWD:/k8s:ro" -w /k8s \
    -v "$HOME/.minikube:$HOME/.minikube:ro" \
    imagedata/kube-helm-docker:0.2.0 "$@"

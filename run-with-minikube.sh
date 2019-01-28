#!/bin/bash

# A helper script to start a Docker environment with kubectl helm helmfile
# preinstalled and configured for connecting to minikube

# helmfile -e minikube sync

if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$PWD" ]; then
    echo Must be run from script parent directory
    exit 2
fi

exec docker run -it --rm \
    -v "$HOME/.kube:/home/kube/.kube:ro" \
    -v "$PWD:/k8s:ro" -w /k8s \
    -v "$HOME/.minikube:$HOME/.minikube:ro" \
    imagedata/kube-helm-docker:0.2.0 "$@"

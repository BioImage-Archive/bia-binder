#!make

BASEDIR = $(shell pwd)
SOURCE:=$(shell source .env secrets.env)


deploy.$1

deploy.$1:
	helmsman --apply --debug --group $1 -f helmsman.yaml -f helmsman/$1.yaml -f helmsman/binder.yaml

deploy.gpu.prod:
	helmsman --apply --debug --group prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --subst-env-values --subst-ssm-values

deploy.denbi.prod:
	helmsman --apply --debug --group prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/denbi.yaml


deploy.dev:
	helmsman --apply --debug --group dev -f helmsman.yaml -f helmsman/dev.yaml -f helmsman/binder.yaml

ci.deploy.prod:
	helmsman --apply --debug --group prod -f helmsman/token.yaml -f helmsman.yaml -f helmsman/prod.yaml
ci.deploy.dev:
	helmsman --apply --debug --group dev -f helmsman/token.yaml -f helmsman.yaml -f helmsman/dev.yaml

binder.deploy.prod:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml --always-upgrade
binder.deploy.dev:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml --always-upgrade

# Beta gpu enabled service


beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade
beta.binder.deploy.dev:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade

# Alpha openstack  service

persistent.alpha.binder.deploy.prod:
	helmsman --apply --debug --target persistent-binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade
persistent.alpha.binder.deploy.dev:
	helmsman --apply --debug --target persistent-binderhub-prod -f helmsman.yaml -f helmsman/openstack.yaml --always-upgrade
# 

alpha.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade
alpha.binder.deploy.dev:
	helmsman --apply --debug --target binderhub-dev -f helmsman.yaml -f helmsman/dev.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.deploy.prod:
	helmsman --apply --debug --group prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.cert.deploy.prod:
	helmsman --apply --debug --target cert-manager-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.trow.deploy.prod:
	helmsman --apply --debug --target trow -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade
alpha.registry.deploy.prod:
	helmsman --apply --debug --target docker-registry -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.ingress.deploy.prod:
	helmsman --apply --debug --target ingress-nginx -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/openstack.yaml --always-upgrade

# Beta gpu enabled service


gpu.beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-prod-gpu -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade
gpu.beta.binder.deploy.dev:
	helmsman --apply --debug --target binderhub-prod-gpu -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade
gpu.beta.triton.deploy.prod:
	helmsman --apply --debug --target tritoninferenceserver -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade

# Dry runs for testing

binder.deploy.prod.dry:
	helmsman --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml --always-upgrade --dry-run

beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

gpu.beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-prod-gpu -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

gpu.cert.deploy.prod:
	helmsman --apply --debug --target cert-manager-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade

gpu.nvdp.prod:
	helmsman --apply --debug --target nvidia-gpu-operator -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gpu.yaml --always-upgrade


gke.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade

gke.binder.deploy.nginx:
	helmsman --apply --debug --target ingress-nginx -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade
gke.binder.deploy.dev:
	helmsman --apply --debug --target binderhub-dev -f helmsman.yaml -f helmsman/dev.yaml -f helmsman/gke.yaml --always-upgrade

gke.nvdp.prod:
	helmsman --apply --debug --target nvidia-device-plugin -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade

gke.deploy.prod:
	helmsman --apply --debug --group prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade
gke.triton.deploy.prod:
	helmsman --apply --debug --target tritoninferenceserver -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade
gke.prometheus.deploy.prod:
	helmsman --apply --debug --target prometheus -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade


gke.persistent.alpha.binder.deploy.prod:
	helmsman --apply --debug --target persistent-binderhub-prod -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/gke.yaml --always-upgrade
gke.persistent.alpha.binder.deploy.dev:
	helmsman --apply --debug --target persistent-binderhub-prod -f helmsman.yaml -f helmsman/gke.yaml --always-upgrade




# CI_REGISTRY_USER = ${CI_REGISTRY_USER} 
# CI_REGISTRY_PASSWORD = ${CI_REGISTRY_PASSWORD}
htpassword:
	docker run --rm -ti xmartlabs/htpasswd ${CI_REGISTRY_USER} ${CI_REGISTRY_PASSWORD} > htpasswd_file
	cat htpasswd_file
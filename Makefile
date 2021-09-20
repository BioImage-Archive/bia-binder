#!make

BASEDIR = $(shell pwd)
SOURCE:=$(shell source secrets.env)
# include .secrets

deploy.prod:
	helmsman --apply --debug --group production -f helmsman/token.yaml -f helmsman.yaml -f helmsman/production.yaml
deploy.staging:	helmsman --apply --debug --group staging -f helmsman/token.yaml -f helmsman.yaml -f helmsman/staging.yaml

binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml --always-upgrade
binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml --always-upgrade

# Beta gpu enabled service


beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade
beta.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade

# Alpha openstack  service

persistent.alpha.binder.deploy.prod:
	helmsman --apply --debug --target persistent-binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade
persistent.alpha.binder.deploy.staging:
	helmsman --apply --debug --target persistent-binderhub-production -f helmsman.yaml -f helmsman/openstack.yaml --always-upgrade
# 

alpha.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade
alpha.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-staging -f helmsman.yaml -f helmsman/staging.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.deploy.prod:
	helmsman --apply --debug --group production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.cert.deploy.prod:
	helmsman --apply --debug --target cert-manager-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.trow.deploy.prod:
	helmsman --apply --debug --target trow -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade
alpha.registry.deploy.prod:
	helmsman --apply --debug --target docker-registry -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade

alpha.ingress.deploy.prod:
	helmsman --apply --debug --target ingress-nginx -f helmsman.yaml -f helmsman/production.yaml -f helmsman/openstack.yaml --always-upgrade

# Beta gpu enabled service


gpu.beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade
gpu.beta.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade
gpu.beta.triton.deploy.prod:
	helmsman --apply --debug --target tritoninferenceserver -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade

# Dry runs for testing

binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml --always-upgrade --dry-run

beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

gpu.beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

gpu.cert.deploy.prod:
	helmsman --apply --debug --target cert-manager-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade



gke.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gke.yaml --always-upgrade

gke.binder.deploy.nginx:
	helmsman --apply --debug --target ingress-nginx -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gke.yaml --always-upgrade
gke.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-staging -f helmsman.yaml -f helmsman/staging.yaml -f helmsman/gke.yaml --always-upgrade

gke.deploy.prod:
	helmsman --apply --debug --group production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gke.yaml --always-upgrade
gke.triton.deploy.prod:
	helmsman --apply --debug --target tritoninferenceserver -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gke.yaml --always-upgrade


gke.persistent.alpha.binder.deploy.prod:
	helmsman --apply --debug --target persistent-binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gke.yaml --always-upgrade
gke.persistent.alpha.binder.deploy.staging:
	helmsman --apply --debug --target persistent-binderhub-production -f helmsman.yaml -f helmsman/gke.yaml --always-upgrade




# CI_REGISTRY_USER = ${CI_REGISTRY_USER} 
# CI_REGISTRY_PASSWORD = ${CI_REGISTRY_PASSWORD}
htpassword:
	docker run --rm -ti xmartlabs/htpasswd ${CI_REGISTRY_USER} ${CI_REGISTRY_PASSWORD} > htpasswd_file
	cat htpasswd_file
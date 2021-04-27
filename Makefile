BASEDIR = $(shell pwd)

deploy.prod:
	helmsman --apply --debug --group production -f helmsman/token.yaml -f helmsman.yaml -f helmsman/production.yaml
deploy.staging:
	helmsman --apply --debug --group staging -f helmsman/token.yaml -f helmsman.yaml -f helmsman/staging.yaml

binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml --always-upgrade
binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml --always-upgrade

# Beta gpu enabled service


beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade
beta.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade

# Beta gpu enabled service


gpu.beta.binder.deploy.prod:
	helmsman --apply --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade
gpu.beta.binder.deploy.staging:
	helmsman --apply --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/gpu.yaml --always-upgrade

# Dry runs for testing

binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml --always-upgrade --dry-run

beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

gpu.beta.binder.deploy.prod.dry:
	helmsman --debug --target binderhub-production-gpu -f helmsman.yaml -f helmsman/production.yaml -f helmsman/gpu.yaml --always-upgrade --dry-run

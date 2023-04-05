#!make


BASEDIR = $(shell pwd)

VARIANTS := embassy denbi
ENVIRONMENTS := prod dev

.PHONY: $(VARIANTS) $(ENVIRONMENTS)

$(VARIANTS):
	@echo "Deploying $@..."
	ENV_FILE=$*.env # set the ENV_FILE variable based on the variant name
	# commands to deploy the variant using the specified .env file

$(ENVIRONMENTS):
	@echo "Deploying to $@..."
	# commands to deploy to the environment

$(VARIANTS:%=%.prod): %.prod:
	@echo "Deploying $* to prod..."
	ENV_FILE=$*.prod.env"
	helmsman --apply --debug --group "prod" -f helmsman.yaml -f helmsman/prod.yaml -f helmsman/$*.yaml

$(VARIANTS:%=%.dev): %.dev:
	@echo "Deploying $* to dev..."
	ENV_FILE=$*.prod.env"
	helmsman --apply --debug --group "dev" -f helmsman.yaml -f helmsman/dev.yaml -f helmsman/$*.yaml

set-env-file:
	
htpassword:
	docker run --rm -ti xmartlabs/htpasswd ${CI_REGISTRY_USER} ${CI_REGISTRY_PASSWORD} > htpasswd_file
	cat htpasswd_file
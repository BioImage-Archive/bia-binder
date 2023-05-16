# Makefile

BASEDIR = $(shell pwd)

VARIANTS := embassy denbi minikube
ENVIRONMENTS := prod dev local

.PHONY: all $(VARIANTS) $(ENVIRONMENTS) $(VARIANTS:%=%.prod) $(VARIANTS:%=%.dev) htpassword

all: $(VARIANTS)

$(VARIANTS): %:
	@echo "Deploying $@..."
	$(MAKE) $@.prod
	$(MAKE) $@.dev

$(ENVIRONMENTS): %:
	@echo "Deploying to $@..."
	ENV_FILE="$*.$@.env"
	$(MAKE) $(VARIANTS:%=%.$@)

$(VARIANTS:%=%.prod): %.prod:
	@echo "Deploying $* to prod..."
	helmsman --apply --debug --group "prod" -f helmsman.yaml -f helmsman/prod.yaml -e $*.prod.env

$(VARIANTS:%=%.dev): %.dev:
	@echo "Deploying $* to dev..."
	helmsman --apply --debug --group "dev" -f helmsman.yaml -f helmsman/dev.yaml -e $*.dev.env

$(VARIANTS:%=%.local): %.local:
	@echo "Deploying $* to local..."
	helmsman --apply --debug --group "prod" -f helmsman.yaml -f helmsman/local.yaml -e $*.local.env

htpassword:
	docker run --rm -ti xmartlabs/htpasswd ${CI_REGISTRY_USER} ${CI_REGISTRY_PASSWORD} > htpasswd_file
	cat htpasswd_file

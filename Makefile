#!/usr/bin/make -f

SHELL:=$(shell which bash)

.PHONY: init validate

DEPLOY_STUBS_CMD=find ./stubs/ -mindepth 1 -maxdepth 1 -type f -name 'stub*.tf' -exec cp {} ./ \;
REMOVE_STUBS_CMD=find ./ -mindepth 1 -maxdepth 1 -type f -name 'stub*.tf' -exec rm {} \;

init:
	@echo '*** initializing module...' >&2
	@if ! terraform init &>/dev/null ; then \
		terraform init ; \
	fi

validate: init
	@# copy all stubs into this directory
	@$(DEPLOY_STUBS_CMD)
	@# run validate
	@echo '*** validating module...' >&2
	@if ! terraform validate ; then \
		$(REMOVE_STUBS_CMD) ; \
		exit 1 ; \
	else \
		$(REMOVE_STUBS_CMD) ; \
	fi
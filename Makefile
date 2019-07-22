######################################################################################
#### 					Terraform Makefile						                  ####
######################################################################################

.ONESHELL:
SHELL := /bin/bash
.DEFAULT_GOAL := help
.PHONY: pytest py pylint pyclean

include terraform/Makefile
ENVIRONMENT ?= big-bang
PYTHON_VERSION ?= 3


venv: requirements.txt ## Create python virtual env
	test -d venv || python -m virtualenv venv --python=python$(PYTHON_VERSION)
	@. venv/bin/activate; pip install --requirement requirements.txt

py: venv ## Activate python venv
	@. venv/bin/activate; python

py_update: venv ## Activate python venv
	@. venv/bin/activate; pip install --requirement requirements.txt

py_lint: venv ## Run lint for python code
	@. venv/bin/activate; pycodestyle ./python/src

py_test: venv ## Run python test suite
	@export PYTHONPATH=$(PYTHONPATH):$(PWD)/python/src && pytest tests

py_clean: ## Cleanup python virtual env and *.pyc
	rm -rf venv
	find -name "*.pyc" -delete

.git/hooks/pre-push:
	@ln --relative --symbolic --force bin/pre-push .git/hooks/pre-push

# TODO: fix regex
help: ## Display this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'










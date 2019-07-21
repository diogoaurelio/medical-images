######################################################################################
#### 					Terraform Makefile						                  ####
######################################################################################

.ONESHELL:
SHELL := /bin/bash
.DEFAULT_GOAL := help
include terraform/Makefile
ENVIRONMENT ?= big-bang

BUCKETKEY = $(ENVIRONMENT)
CUR_DIR = $(PWD)

pytest: ## Run python test suite
	@export PYTHONPATH=$(PYTHONPATH):$(PWD)/python/src && pytest tests

# TODO: fix regex
help: ## Display this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'










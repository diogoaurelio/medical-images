
TMP ?= /tmp
TERRAFORM ?= $(PWD)/bin/terraform
# Default version
# You can override the Terraform version at the main Makefile at your project,e.g.:
# export TERRAFORM_VERSION ?= 0.11.12

OS ?= linux


TERRAFORM_VERSION ?= 0.12.5
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip
TERRAFORM_PLAN=terraform.plan
TERRAFORM_VARS=$(PWD)/terraform/$(ENVIRONMENT)/secrets.tfvars

USE_TERRAFORM=$(cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM))

echo_terraform: ## change into terraform directory
	$(USE_TERRAFORM)

cd_terraform: ## change into terraform directory
	cd $(PWD)/terraform/$(ENVIRONMENT)

terraform_install: ## Install terraform
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing Terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -f $(TMP)/terraform.zip \
		)
	$(TERRAFORM) version

terraform_clean: ## Clean terraform
		rm -f $(TERRAFORM)

terraform_init: ## Initialize terraform to ensure all plugins can be fetched
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) init

terraform_get-plugins: cd_terraform ## Ensure all plugins can be fetched
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) init -get-plugins -backend=false -input=false >/dev/null


terraform_get-modules: cd_terraform ## Ensure all modules can be fetched
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) init -get -backend=false -input=false >/dev/null

terraform_validate: cd_terraform ## Basic terraform sanity check
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) validate -check-variables=false

terraform_lint: cd_terraform ## Lint check Terraform
	@FAIL=`cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)

terraform_check: ## Checks Terraform format and validate .tf files.
	@$(TERRAFORM) --version
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) get
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) fmt
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) validate -var-file=$(TERRAFORM_VARS)

terraform_plan: terraform_init terraform_get-plugins terraform_get-modules terraform_check ## Plans the project
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) plan -var-file=$(TERRAFORM_VARS)

terraform_apply: cd_terraform terraform_plan ## Apply Terraform plan
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) apply -var-file=$(TERRAFORM_VARS)

terraform_apply_auto: cd_terraform terraform_plan ## Apply Terraform plan
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) apply -auto-approve -var-file=$(TERRAFORM_VARS)

terraform_destroy: cd_terraform terraform_get-plugins terraform_get-modules terraform_check ## Destroys resources created by Terraform
	@cd $(PWD)/terraform/$(ENVIRONMENT) && $(TERRAFORM) destroy -auto-approve && rm -rf .terraform/&& rm -f $(TERRAFORM_PLAN) terraform.tfstate*

terraform_recreate: cd_terraform terraform_destroy terraform_apply ## Destroys and creates the project again


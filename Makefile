# Makefile for Container Image Building Management

# configuration
ARGS                  :=
BINARY_DOCKER 	      ?= docker
BINARY_OP              = $(call check_for_binary,op)
BINARY_PACKER         ?= packer
BINARY_YAMLLINT       ?= yamllint
DIR_DIST				      ?= dist
DOCS_CONFIG            = .packer-docs.yml
IMAGE_NAME            ?= $(shell basename $(image))
SNYK_ORG				      ?= workloads
YAMLLINT_CONFIG       ?= .yaml-lint.yml
YAMLLINT_FORMAT	      ?= colored
TITLE                  = 🐳 CONTAINER IMAGES

args_except = -except="docker-push"

# enable pushing of image if `push` has been passed
ifdef push
args_except =
endif

# convenience handle for ALL CLI arguments
cli_args = $(args_except)

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk
include ../tooling/make/functions/packer.mk

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: init
init: # initialize a Packer Template [Usage: `make init template=my_template`]
	$(if $(template),,$(call missing_argument,init,template=my_template))

	$(call print_args,$(ARGS))
	$(call packer_init,$(template))

.SILENT .PHONY: lint
lint: # lint a Container Image Template [Usage: `make lint template=my_template`]
	$(if $(template),,$(call missing_argument,lint,template=my_template))

	$(call print_args,$(ARGS))
	$(call packer_lint,$(template))

.SILENT .PHONY: build
build: # build a Container Image [Usage: `make build template=my_template`]
	$(if $(template),,$(call missing_argument,build,template=my_template))

	$(call print_args,$(ARGS))
	$(call packer_build,$(template))

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs template=my_template`]
	$(if $(template),,$(call missing_argument,docs,template=my_template))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(strip $(template)),variables.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console template=my_template`]
	$(if $(template),,$(call missing_argument,console,template=my_template))

	$(call print_args,$(ARGS))
	$(call packer_console,$(template))

.SILENT .PHONY: snyk_test
snyk_test: # test Image with Snyk Container [Usage: `make snyk_test image=my_image`]
	$(if $(image),,$(call missing_argument,console,image=my_image))

	# see https://docs.snyk.io/snyk-cli/commands/container-test
	snyk \
		container \
			test \
				--app-vulns \
				--fail-on=all \
				--org="$(SNYK_ORG)" \
				--print-deps \
				--sarif-file-output="$(DIR_DIST)/$(IMAGE_NAME).sarif" \
				"$(image)"

.SILENT .PHONY: yaml_lint
yaml_lint: # lint YAML files [Usage: `make yaml_lint`]
	$(call yaml_lint)

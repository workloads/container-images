# Makefile for Docker Image Building Management

# configuration
ARGS            :=
BINARY_DOCKER 	?= docker
BINARY_PACKER   ?= packer
BINARY_YAMLLINT ?= yamllint
DOCS_CONFIG      = .packer-docs.yml
YAMLLINT_CONFIG ?= .yaml-lint.yml
YAMLLINT_FORMAT	?= colored
TITLE            = 🐳 DOCKER IMAGES

# convenience handle for ALL CLI arguments
cli_args =

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk
include ../tooling/make/functions/packer.mk

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: init
init: # initialize a Packer Template [Usage: `make init image=my_image`]
	$(if $(image),,$(call missing_argument,init,image=my_image))

	$(call print_args,$(ARGS))
	$(call packer_init,$(image))

.SILENT .PHONY: lint
lint: # lint a Docker Image Template [Usage: `make lint image=my_image`]
	$(if $(image),,$(call missing_argument,lint,image=my_image))

	$(call print_args,$(ARGS))
	$(call packer_lint,$(image))

.SILENT .PHONY: build
build: # build a Docker Image [Usage: `make build image=my_image`]
	$(if $(image),,$(call missing_argument,build,image=my_image))

	$(call print_args,$(ARGS))
	$(call packer_build,$(image))

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs image=my_image`]
	$(if $(image),,$(call missing_argument,docs,image=my_image))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(strip $(image)),variables.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console image=my_image`]
	$(if $(image),,$(call missing_argument,console,image=my_image))

	$(call print_args,$(ARGS))
	$(call packer_console,$(image))

.SILENT .PHONY: yaml_lint
yaml_lint: # lint YAML files [Usage: `make yaml_lint`]
	$(call yaml_lint)

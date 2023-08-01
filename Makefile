# Makefile for Container Image Building Management

# configuration
ARGS                  :=
BINARY_DOCKER 	      ?= docker
BINARY_OP              = $(call check_for_binary,op)
BINARY_PACKER         ?= packer
BINARY_YAMLLINT       ?= yamllint
DIR_DIST              ?= dist
DOCS_CONFIG            = .packer-docs.yml
IMAGE_NAME            ?= $(shell basename $(image))
OP_ACCOUNT             = workloads.1password.com
OP_ENV_FILE            = secrets.op.env
REGISTRY_ADDRESS      ?= ghcr.io
REGISTRY_PASSWORD_REF ?= "op://Shared/github/tokens/container-images"
REGISTRY_USERNAME     ?= $(shell op read --account="$(OP_ACCOUNT)" --no-newline "$(REGISTRY_USERNAME_REF)")
REGISTRY_USERNAME_REF ?= "op://Shared/github/username"
REGISTRY_PASSWORD 	  ?= $(shell op read --account="$(OP_ACCOUNT)" --no-newline "$(REGISTRY_PASSWORD_REF)")
SNYK_ORG              ?= workloads
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
init: # initialize a Packer Template [Usage: `make init template=<template>`]
	$(if $(template),,$(call missing_argument,init,template=<template>))

	$(call print_args,$(ARGS))
	$(call packer_init,$(template))

.SILENT .PHONY: lint
lint: # lint a Container Image Template [Usage: `make lint template=<template>`]
	$(if $(template),,$(call missing_argument,lint,template=<template>))

	$(call print_args,$(ARGS))
	$(call packer_lint,$(template))

.SILENT .PHONY: build
build: # build a Container Image [Usage: `make build template=<template>`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	$(call print_args,$(ARGS))
	$(call packer_build_with_secrets,$(template))

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs template=<template>`]
	$(if $(template),,$(call missing_argument,docs,template=<template>))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(strip $(template)),variables.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console template=<template>`]
	$(if $(template),,$(call missing_argument,console,template=<template>))

	$(call print_args,$(ARGS))
	$(call packer_console,$(template))

.SILENT .PHONY: print-secrets
print-secrets: # print (sanitized) environment variables [Usage: `make print-secrets`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	$(call print_secrets,"PACKER_TARGET_")

.SILENT .PHONY: snyk_test
snyk_test: # test Image with Snyk Container [Usage: `make snyk_test image=<image>`]
	$(if $(image),,$(call missing_argument,console,image=<image>))

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

.SILENT .PHONY: _registry_login
_registry_login: # log in to a (Docker) Registry [Usage: `make _registry_login`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	# see https://docs.docker.com/engine/reference/commandline/login/
	# and https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
	echo "$(REGISTRY_PASSWORD)" \
	| \
	$(BINARY_DOCKER) \
		login \
			--username="$(REGISTRY_USERNAME)" \
			--password-stdin \
			"$(REGISTRY_ADDRESS)"

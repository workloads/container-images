# Makefile for Container Image Building Management

# configuration
ARGS                  :=
BINARY_DOCKER 	      ?= docker
BINARY_OP              = $(call check_for_binary,op)
BINARY_PACKER         ?= packer
BINARY_YAMLLINT       ?= yamllint
DIR_DIST              ?= dist
DIR_PACKER            ?= .
DIR_BUILD              = $(DIR_PACKER)/$(builder)
DOCS_CONFIG            = .packer-docs.yml
IMAGE_NAME            ?= $(shell basename $(image))
OP_ACCOUNT             = workloads.1password.com
OP_ENV_FILE            = secrets.op.env
PLATFORM              ?= $(shell uname -m) # default to system arch; common values are `x86_64` and `arm64`
REGISTRY_ADDRESS      ?= ghcr.io
REGISTRY_PASSWORD_REF ?= "op://Shared/github/tokens/container-images"
REGISTRY_USERNAME     ?= $(shell op read --account="$(OP_ACCOUNT)" --no-newline "$(REGISTRY_USERNAME_REF)")
REGISTRY_USERNAME_REF ?= "op://Shared/github/username"
REGISTRY_PASSWORD     ?= $(shell op read --account="$(OP_ACCOUNT)" --no-newline "$(REGISTRY_PASSWORD_REF)")
FILES_SHARED          ?= "variables_shared.pkr.hcl" "builders_shared.pkr.hcl"
SNYK_ORG              ?= workloads
VERSION               ?= $(shell TZ=UTC date +'%Y%m%d-%H%M')
YAMLLINT_CONFIG       ?= .yaml-lint.yml
YAMLLINT_FORMAT	      ?= colored
TITLE                  = 🐳 CONTAINER IMAGES

args_except = -except="docker-push"

# enable pushing of image if `push` has been passed
ifdef push
args_except =
endif

# convenience handle for ALL CLI arguments
cli_args = $(args_except) -var="target_platform=$(strip $(PLATFORM))" "-var=target_version=$(strip $(VERSION))"

include ../tooling/make/configs/shared.mk
include ../tooling/make/functions/shared.mk
include ../tooling/make/functions/packer.mk
include ../tooling/make/targets/packer.mk
include ../tooling/make/targets/shared.mk

.SILENT .PHONY: init
init: # initialize a Packer Template [Usage: `make init template=<template>`]
	$(if $(template),,$(call missing_argument,template=<template>))

	$(call print_args)
	$(call packer_init,$(template))

.SILENT .PHONY: lint
lint: # lint a Container Image Template [Usage: `make lint template=<template>`]
	$(if $(template),,$(call missing_argument,template=<template>))

	$(call print_args)
	$(call packer_lint,$(template))

.SILENT .PHONY: build
build: # build a Container Image [Usage: `make build template=<template>`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif
	$(if $(template),,$(call missing_argument,template=<template>))

	$(call print_args)
	$(call packer_build_with_secrets,$(template))

.SILENT .PHONY: docs
docs: # generate documentation for all Packer Images [Usage: `make docs template=<template>`]
	$(if $(template),,$(call missing_argument,template=<template>))

	# TODO: align with overall `render_documentation` function
	$(call render_documentation,$(strip $(template)),variables.pkr.hcl,$(DOCS_CONFIG),sample.pkrvars.hcl)

.SILENT .PHONY: console
console: # start Packer Console [Usage: `make console template=<template>`]
	$(if $(template),,$(call missing_argument,template=<template>))

	$(call print_args)
	$(call packer_console,$(template))

.SILENT .PHONY: print-secrets
print-secrets: # print (sanitized) environment variables [Usage: `make print-secrets`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	$(call print_secrets,"PACKER_TARGET_")

.SILENT .PHONY: snyk_test
snyk_test: # test Image with Snyk Container [Usage: `make snyk_test image=<image>`]
	$(if $(image),,$(call missing_argument,image=<image>))

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

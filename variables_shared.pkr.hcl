# see https://developer.hashicorp.com/packer/plugins/builders/docker#commit
variable "commit" {
  type        = bool
  description = "Toggle to commit the Container Image, rather than export it."
  default     = true
}

variable "force_tag" {
  type        = bool
  description = "Forcibly tag Image, even if an identical Tag already exists."
  default     = true
}

variable "keep_input_artifact" {
  type        = bool
  description = "Toggle to keep the input Artifact after pushing to an Image Registry."
  default     = true
}

locals {
  # labels that are shared between all images
  labels = [
    # see https://specs.opencontainers.org/image-spec/annotations/#pre-defined-annotation-keys
    "LABEL org.opencontainers.image.authors='${var.target_image_repository_namespace}'",
    "LABEL org.opencontainers.image.authors=${var.target_image_repository_namespace}",
    "LABEL org.opencontainers.image.created='${timestamp()}'",
    "LABEL org.opencontainers.image.documentation='${local.image_source}/README.md'",
    "LABEL org.opencontainers.image.url='${local.image_source}'",
    "LABEL org.opencontainers.image.ref='${var.target_image_name}'",
    "LABEL org.opencontainers.image.revision='${var.target_version}'",
    "LABEL org.opencontainers.image.vendor='${var.target_image_repository_namespace}'",
    "LABEL org.opencontainers.image.version='${var.target_version}'",
    "LABEL org.opencontainers.image.title='${var.target_image_name}'",

    # label images for publishing via GitHub Container Registry
    # see https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#labelling-container-images
    "LABEL org.opencontainers.image.description='${var.target_image_description}'",
    "LABEL org.opencontainers.image.licenses='${var.target_image_license}'",
    "LABEL org.opencontainers.image.source='${local.image_source}'",
  ]
}

variable "platforms" {
  type        = map(string)
  description = "Map of Platforms."

  default = {
    "arm"    = "linux/arm/v7",
    "arm64"  = "linux/arm64/v8",
    "x86_64" = "linux/amd64",
  }
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#pull
variable "pull" {
  type        = bool
  description = "Toggle to pull the Container Image prior to building."
  default     = true
}

variable "target_image_org" {
  type        = string
  description = "Namespace / Organization of the Output Container Image."
  default     = "workloads"
}

variable "target_image_license" {
  type        = string
  description = "License of the Output Container Image."
  default     = "Apache-2.0"
}

variable "target_registry_password" {
  type        = string
  description = "Password of the Container Registry of the Output Container Image. Parsed using `env()`."
  default     = env("PACKER_TARGET_REGISTRY_PASSWORD")
}

variable "target_registry_server" {
  type        = string
  description = "Address of the Container Registry of the Output Container Image."
  default     = "ghcr.io"
}

variable "target_registry_username" {
  type        = string
  description = "Username of the Container Registry of the Output Container Image. Parsed using `env()`."
  default     = env("PACKER_TARGET_REGISTRY_USERNAME")
}

# `target_version` as received from `make`
variable "target_version" {
  type        = string
  description = "Target Version Output Container Image as received from `make`."
}

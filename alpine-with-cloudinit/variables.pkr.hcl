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

# see https://developer.hashicorp.com/packer/docs/provisioners/shell#inline
variable "inline_commands" {
  type        = list(string)
  description = "Commands to run with the Shell Provisioner."

  default = [
    # update APK index
    "apk update",

    # upgrade installed packages
    "apk upgrade",

    # install cloud-init
    "apk add cloud-init",

    # fix possibly broken packages
    "apk fix",
  ]
}

# see https://developer.hashicorp.com/packer/docs/provisioners/shell#inline_shebang
variable "inline_shebang" {
  type        = string
  description = "Shebang to use with the Shell Provisioner."
  default     = "/bin/sh -e"
}

variable "keep_input_artifact" {
  type        = bool
  description = "Toggle to keep the input Artifact after pushing to an Image Registry."
  default     = true
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#pull
variable "pull" {
  type        = bool
  description = "Toggle to pull the Container Image prior to building."
  default     = true
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_image" {
  type        = string
  description = "Namespace and Image Slug of the Input Container Image."
  default     = "alpine"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_registry" {
  type        = string
  description = "Registry of the Input Container Image."
  default     = "index.docker.io"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_version" {
  type        = string
  description = "Version of the Input Container Image."
  default     = "3.18.2"
}

locals {
  source_content_address = "${var.source_registry}/${var.source_image}:${var.source_version}"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "target_image_org" {
  type        = string
  description = "Namespace / Organization of the Output Container Image."
  default     = "workloads"
}

variable "target_image_name" {
  type        = string
  description = "Name of the Output Container Image."
  default     = "alpine-with-cloudinit"
}

variable "target_image_repository_namespace" {
  type        = string
  description = "Source Namespace of the Output Container Image."
  default     = "https://github.com/workloads"
}

variable "target_image_repository_slug" {
  type        = string
  description = "Source Repository of the Output Container Image."
  default     = "container-images/tree/main/alpine-with-cloudinit"
}

variable "target_image_description" {
  type        = string
  description = "Description of the Output Container Image."
  default     = "Alpine Linux with Cloud-Init"
}

variable "target_image_license" {
  type        = string
  description = "License of the Output Container Image."
  default     = "Apache-2.0"
}

variable "target_registry_password" {
  type        = string
  description = "Password of the Container Registry of the Output Container Image. Parsed using `env()`."
  default     = "PACKER_TARGET_REGISTRY_PASSWORD"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "target_registry_server" {
  type        = string
  description = "Address of the Container Registry of the Output Container Image."
  default     = "ghcr.io"
}

variable "target_registry_username" {
  type        = string
  description = "Username of the Container Registry of the Output Container Image. Parsed using `env()`."
  default     = "PACKER_TARGET_REGISTRY_USERNAME"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "target_version" {
  type        = string
  description = "Version of the Output Container Image."
  default     = "latest"
}

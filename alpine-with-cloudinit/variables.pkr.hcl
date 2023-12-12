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

# see https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_image" {
  type        = string
  description = "Namespace and Image Slug of the Input Container Image."
  default     = "alpine"
}

variable "source_payload" {
  type        = string
  description = "File or Directory to upload to the Output Container Image."
  default     = null
}

# see https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_registry" {
  type        = string
  description = "Registry of the Input Container Image."
  default     = "index.docker.io"
}

# see https://hub.docker.com/_/alpine/tags
# and https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_version" {
  type        = map(string)
  description = "Platform Map of Versions of the Input Container Image."

  default     = {
    "arm"    = "3.19.0@sha256:41f5f86616c51186dde18811bae696c689d6d492e1428f84fd74d42b43799c71",
    "arm64"  = "3.19.0@sha256:a70bcfbd89c9620d4085f6bc2a3e2eef32e8f3cdf5a90e35a1f95dcbd7f71548",
    "x86_64" = "3.19.0@sha256:13b7e62e8df80264dbb747995705a986aa530415763a6c58f84a3ca8af9a5bcd",
  }
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

variable "target_image_description" {
  type        = string
  description = "Description of the Output Container Image."
  default     = "Alpine Linux with Cloud-Init"
}

variable "target_image_workdir" {
  type        = string
  description = "WORKDIR of the Output Container Image."
  default     = "/"
}

locals {
  source_content_address       = "${var.source_registry}/${var.source_image}:${var.source_version[var.target_platform]}"
  target_image_repository_slug = "container-images/tree/main/${var.target_image_name}"
  image_source                 = "${var.target_image_repository_namespace}/${local.target_image_repository_slug}"
}

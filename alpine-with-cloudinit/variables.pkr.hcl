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

# see https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_registry" {
  type        = string
  description = "Registry of the Input Container Image."
  default     = "index.docker.io"
}

# see https://hub.docker.com/_/alpine/tags
# and https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_version" {
  type        = string
  description = "Version of the Input Container Image."
  default     = "3.18.3"
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

locals {
  source_content_address       = "${var.source_registry}/${var.source_image}:${var.source_version}"
  target_image_repository_slug = "container-images/tree/main/${var.target_image_name}"
  image_source                 = "${var.target_image_repository_namespace}/${local.target_image_repository_slug}"
}

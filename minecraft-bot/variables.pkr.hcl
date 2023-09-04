# see https://developer.hashicorp.com/packer/docs/provisioners/shell#inline_shebang
variable "inline_shebang" {
  type        = string
  description = "Shebang to use with the Shell Provisioner."
  default     = "/bin/sh -e"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_image" {
  type        = string
  description = "Namespace and Image Slug of the Input Container Image."
  default     = "node"
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_registry" {
  type        = string
  description = "Registry of the Input Container Image."
  default     = "index.docker.io"
}

# see https://hub.docker.com/_/node/tags
# and https://developer.hashicorp.com/packer/plugins/builders/docker#image
variable "source_version" {
  type        = string
  description = "Version of the Input Container Image."
  default     = "20.5.1-bookworm-slim"
}

variable "target_image_name" {
  type        = string
  description = "Name of the Output Container Image."
  default     = "minecraft-bot"
}

variable "target_image_repository_namespace" {
  type        = string
  description = "Source Namespace of the Output Container Image."
  default     = "https://github.com/workloads"
}

variable "target_image_description" {
  type        = string
  description = "Description of the Output Container Image."
  default     = "Minecraft Bot on Node (Slim, Bookworm LTS)"
}

locals {
  source_content_address       = "${var.source_registry}/${var.source_image}:${var.source_version}"
  target_image_repository_slug = "container-images/tree/main/${var.target_image_name}"
  image_source                 = "${var.target_image_repository_namespace}/${local.target_image_repository_slug}"
}

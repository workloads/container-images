# see https://developer.hashicorp.com/packer/docs/provisioners/shell#inline
variable "inline_commands" {
  type        = list(string)
  description = "Commands to run with the Shell Provisioner."

  default = [
    # disable NPM audit, fund, and update notifications
    # see https://docs.npmjs.com/cli/v9/commands/npm-config
    "npm config set audit false",
    "npm config set fund false",
    "npm config set update-notifier false",

    # change into working directory and install dependencies
    # see https://docs.npmjs.com/cli/v10/commands/npm-install
    "cd /srv && npm install",
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
  default     = "node"
}

variable "source_payload" {
  type        = string
  description = "File or Directory to upload to the Output Container Image."

  # TODO: change
  # If this is a directory, include a trailing slash
  default = "../minecraft-bot/"
}

# TODO: add support for excluding files
variable "source_payload_exclude" {
  type        = list(string)
  description = "File and Directories to exclude from upload to the Output Container Image."

  default = [
    ".envrc",
    ".eslintignore",
    ".eslintrc.json",
    ".git",
    ".gitignore",
    "*.log",
    "dist",
    "Dockerfile",
    "tsconfig.json",
  ]
}

# see https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_registry" {
  type        = string
  description = "Registry of the Input Container Image."
  default     = "index.docker.io"
}

# see https://hub.docker.com/_/node/tags?name=18-bookworm-slim
# and https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker#image
variable "source_version" {
  type = map(string)
  description = "Platform Map of Versions of the Input Container Image."

  default = {
    "arm"    = "18-bookworm-slim@sha256:bd4cfdbcdf79c9c500f19366c86c5f934cdc26a8a8ed20710078a4bb695934ee",
    "arm64"  = "18-bookworm-slim@sha256:607a90ca0915374e81693b75ff260145a3f75e2abac9732165322e3d961ca2d7",
    "x86_64" = "18-bookworm-slim@sha256:28b1bfae5e6454793e89934c79ebf9c18dc844da8d6af3617c80bb2d2ccc6d53",
  }
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

variable "target_image_workdir" {
  type        = string
  description = "WORKDIR of the Output Container Image."
  default     = "/srv"
}

locals {
  source_content_address       = "${var.source_registry}/${var.source_image}:${var.source_version[var.target_platform]}"
  target_image_repository_slug = "container-images/tree/main/${var.target_image_name}"
  image_source                 = "${var.target_image_repository_namespace}/${local.target_image_repository_slug}"
}

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

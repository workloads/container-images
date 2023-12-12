# see https://developer.hashicorp.com/packer/integrations/hashicorp/docker/latest/components/builder/docker
source "docker" "main" {
  # see https://developer.hashicorp.com/packer/plugins/builders/docker#changes
  # and https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/collection/concat
  changes = concat([
    "WORKDIR ${var.target_image_workdir}",

    "ENTRYPOINT /usr/bin/cloud-init schema --config-file /config/*",
  ], local.labels)

  fix_upload_owner = true
  commit           = var.commit
  image            = local.source_content_address
  platform         = var.platform
  pull             = var.pull
}

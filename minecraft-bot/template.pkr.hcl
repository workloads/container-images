# see https://developer.hashicorp.com/packer/plugins/builders/docker
source "docker" "main" {
  # see https://developer.hashicorp.com/packer/plugins/builders/docker#changes
  # and https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/collection/concat
  changes = concat([
    "WORKDIR ${var.target_image_workdir}",

    # use image-supplied user to avoid running as root
    "USER node",

    # switch Node to "production mode" to avoid installing dev dependencies
    # "ENV NODE_ENV production",

    "ENTRYPOINT /usr/local/bin/node dist/index.js",
  ], local.labels)

  fix_upload_owner = true
  commit           = var.commit
  image            = local.source_content_address
  platform         = var.platform
  pull             = var.pull
}

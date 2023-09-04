# see https://developer.hashicorp.com/packer/plugins/builders/docker
source "docker" "main" {
  # see https://developer.hashicorp.com/packer/plugins/builders/docker#changes
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

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#commit
  commit = var.commit

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#image
  image = local.source_content_address

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#pull
  pull = var.pull
}

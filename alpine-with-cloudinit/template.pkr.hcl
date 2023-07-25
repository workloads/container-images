packer {
  required_plugins {
    # see https://developer.hashicorp.com/packer/plugins/builders/docker
    docker = {
      # see https://github.com/hashicorp/packer-plugin-docker/releases/
      version = "1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

# see https://developer.hashicorp.com/packer/plugins/builders/docker
source "docker" "main" {
  # see https://developer.hashicorp.com/packer/plugins/builders/docker#changes
  changes = [
    "ENTRYPOINT /usr/bin/cloud-init schema --config-file /config/*",

    # see https://specs.opencontainers.org/image-spec/annotations/#pre-defined-annotation-keys
    "LABEL org.opencontainers.image.authors='${var.target_image_repository_namespace}'",
    "LABEL org.opencontainers.image.authors=${var.target_image_repository_namespace}",
    "LABEL org.opencontainers.image.created='${timestamp()}'",
    "LABEL org.opencontainers.image.documentation='${var.target_image_repository_namespace}/${var.target_image_repository_slug}/README.md'",
    "LABEL org.opencontainers.image.url='${var.target_image_repository_namespace}/${var.target_image_repository_slug}'",
    "LABEL org.opencontainers.image.ref='${var.target_image_name}'",
    "LABEL org.opencontainers.image.revision='${var.target_version}'",
    "LABEL org.opencontainers.image.vendor='${var.target_image_repository_namespace}'",
    "LABEL org.opencontainers.image.version='${var.target_version}'",
    "LABEL org.opencontainers.image.title='${var.target_image_name}'",

    # label images for publishing via GitHub Container Registry
    # see https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#labelling-container-images
    "LABEL org.opencontainers.image.description='${var.target_image_description}'",
    "LABEL org.opencontainers.image.licenses='${var.target_image_license}'",
    "LABEL org.opencontainers.image.source='${var.target_image_repository_namespace}/${var.target_image_repository_slug}'",
  ]

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#commit
  commit = var.commit

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#image
  image = local.source_content_address

  # see https://developer.hashicorp.com/packer/plugins/builders/docker#pull
  pull = var.pull
}

# see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/build
build {
  name = "1-provisioners"

  sources = [
    "source.docker.main",
  ]

  # see https://developer.hashicorp.com/packer/docs/provisioners/shell
  provisioner "shell" {
    inline         = var.inline_commands
    inline_shebang = var.inline_shebang
  }

  post-processors {
    # see https://developer.hashicorp.com/packer/plugins/builders/docker#using-the-artifact-committed
    # and https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-tag
    post-processor "docker-tag" {
      force      = var.force_tag
      repository = "${var.target_registry_server}/${var.target_image_org}/${var.target_image_name}"

      tags = [
        var.target_version
      ]
    }

    # see https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-push
    post-processor "docker-push" {
      keep_input_artifact = var.keep_input_artifact

      # see https://developer.hashicorp.com/packer/plugins/post-processors/docker/docker-push#login
      login          = true
      login_server   = var.target_registry_server
      login_password = var.target_registry_password
      login_username = var.target_registry_username
    }
  }
}

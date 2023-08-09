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

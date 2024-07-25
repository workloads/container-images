# Container Image: `minecraft-bot`

![Container Image: `minecraft-bot`](https://assets.workloads.io/container-images/minecraft-bot.png)

## Table of Contents

<!-- TOC -->
* [Container Image: `minecraft-bot`](#container-image-minecraft-bot)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
  * [Usage](#usage)
    * [Inputs](#inputs)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.11.0` or [newer](https://developer.hashicorp.com/packer/downloads)
- Docker `24.0.0` or [newer](https://www.docker.com/products/docker-desktop/)
  - alternate compatible runtimes (e.g.: Podman, OrbStack) may be used

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [template.pkr.hcl](template.pkr.hcl)   |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build command   | `make build template=./minecraft-bot`  |
| lint command    | `make lint template=./minecraft-bot`   |

## Usage

The `minecraft-bot` image should be run like so::

```shell
docker \
  run \
    --env-file ".env" \
    --interactive \
    --quiet \
    --rm \
    --tty \
    ghcr.io/workloads/minecraft-bot:latest
```

<!-- BEGIN_PACKER_DOCS -->
### Inputs

| Name | Description | Default |
|------|-------------|---------|
| commit | Toggle to commit the Container Image, rather than export it. | `true` |
| force_tag | Forcibly tag Image, even if an identical Tag already exists. | `true` |
| inline_commands | Commands to run with the Shell Provisioner. | ```[ "npm config set audit false", "npm config set fund false", "npm config set update-notifier false", "cd /srv && npm install" ]``` |
| inline_shebang | Shebang to use with the Shell Provisioner. | `"/bin/sh -e"` |
| keep_input_artifact | Toggle to keep the input Artifact after pushing to an Image Registry. | `true` |
| platforms | Map of Platforms. | ```{ "arm": "linux/arm/v7", "arm64": "linux/arm64/v8", "x86_64": "linux/amd64" }``` |
| pull | Toggle to pull the Container Image prior to building. | `true` |
| source_image | Namespace and Image Slug of the Input Container Image. | `"node"` |
| source_payload | File or Directory to upload to the Output Container Image. | `"../minecraft-bot/"` |
| source_payload_exclude | File and Directories to exclude from upload to the Output Container Image. | ```[ ".envrc", ".eslintignore", ".eslintrc.json", ".git", ".gitignore", "*.log", "dist", "Dockerfile", "tsconfig.json" ]``` |
| source_registry | Registry of the Input Container Image. | `"index.docker.io"` |
| source_version | Platform Map of Versions of the Input Container Image. | ```{ "arm": "18-bookworm-slim@sha256:bd4cfdbcdf79c9c500f19366c86c5f934cdc26a8a8ed20710078a4bb695934ee", "arm64": "18-bookworm-slim@sha256:607a90ca0915374e81693b75ff260145a3f75e2abac9732165322e3d961ca2d7", "x86_64": "18-bookworm-slim@sha256:28b1bfae5e6454793e89934c79ebf9c18dc844da8d6af3617c80bb2d2ccc6d53" }``` |
| target_image_description | Description of the Output Container Image. | `"Minecraft Bot on Node (Slim, Bookworm LTS)"` |
| target_image_license | License of the Output Container Image. | `"Apache-2.0"` |
| target_image_name | Name of the Output Container Image. | `"minecraft-bot"` |
| target_image_org | Namespace / Organization of the Output Container Image. | `"workloads"` |
| target_image_repository_namespace | Source Namespace of the Output Container Image. | `"https://github.com/workloads"` |
| target_image_workdir | WORKDIR of the Output Container Image. | `"/srv"` |
| target_platform | Target Platform as received from `make`. | n/a |
| target_registry_password | Password of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_PASSWORD"` |
| target_registry_server | Address of the Container Registry of the Output Container Image. | `"ghcr.io"` |
| target_registry_username | Username of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_USERNAME"` |
| target_version | Target Version Output Container Image as received from `make`. | n/a |
<!-- END_PACKER_DOCS -->

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.

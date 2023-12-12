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
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.0` or [newer](https://developer.hashicorp.com/packer/downloads)
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
| inline_commands | Commands to run with the Shell Provisioner. | ```[ "echo 'Hello, World!'" ]``` |
| inline_shebang | Shebang to use with the Shell Provisioner. | `"/bin/sh -e"` |
| keep_input_artifact | Toggle to keep the input Artifact after pushing to an Image Registry. | `true` |
| pull | Toggle to pull the Container Image prior to building. | `true` |
| source_image | Namespace and Image Slug of the Input Container Image. | `"node"` |
| source_registry | Registry of the Input Container Image. | `"index.docker.io"` |
| source_version | Version of the Input Container Image. | `"20.5.1-bookworm-slim"` |
| target_image_description | Description of the Output Container Image. | `"Minecraft Bot on Node (Slim, Bookworm LTS)"` |
| target_image_license | License of the Output Container Image. | `"Apache-2.0"` |
| target_image_name | Name of the Output Container Image. | `"minecraft-bot"` |
| target_image_org | Namespace / Organization of the Output Container Image. | `"workloads"` |
| target_image_repository_namespace | Source Namespace of the Output Container Image. | `"https://github.com/workloads"` |
| target_registry_password | Password of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_PASSWORD"` |
| target_registry_server | Address of the Container Registry of the Output Container Image. | `"ghcr.io"` |
| target_registry_username | Username of the Container Registry of the Output Container Image. Parsed using `env()`. | `"PACKER_TARGET_REGISTRY_USERNAME"` |
| target_version | Target Version Output Container Image as received from `make`. | n/a |
<!-- END_PACKER_DOCS -->

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/container-images/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
